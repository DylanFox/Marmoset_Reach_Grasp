function [unfiltered_data, filtered_data] = ReachGraspImport(~)
%Used to import multiple text files generated from Tracker Software
%(v4.9.8) into a tabular format. Files are imported, stripped into their
%individual components and then passed through a noise filter (2nd pass
%butterworth)

% Three txt files were generated from a single tracker video - X_thumbdata,
% X_indexdata and Grip aperture. This code imports these and ensures each
% video (or trial) is separated by rows while each parameter is sorted by
% columns

%This function uses the normalize_var function so make sure it is within
%the file path.


%Ensure files you are importing are in the current folder directory, these
%were taken from a GOPRO camera which adds a prefix of 'GOPR' which this
%accounts for. This can be changed to whatever file naming format you
%choose.

%[raw_KinematicTable, filt_KinematicTable] = ReachGraspImport; This will
%produce two tables of N x 9 matrix of raw data inputs and a N x 35 matrix
%of filtered data where N is the number of trials recorded It might be
%helpful to include categorical data such as participant/subject no., Exp
%condition, etc.

%------------IMPORT------------%
unfiltered_data = dir('GOPR*_*.txt');
nfiles = length(unfiltered_data);

%not sure how to preallocate this block
data = [];

for k = 1:nfiles
   data = [data; importdata(unfiltered_data(k).name)];
end
t = struct2table(data);

%Separate the fields to the one we want (which is the data)
datatable = t.data;

%Separate MGA, Velocity and foodwidth into separate categories
%Sort folder according to type to have all .txt
%files in the same line
IndexTrials = datatable(1:3:end);
MgaTrials = datatable(2:3:end);
ThumbTrials = datatable(3:3:end);
unfiltered_data = table(MgaTrials,ThumbTrials,IndexTrials);

%------------STRIP VELOCITY, X/Y POSN and ACCEL data------------%
%Strip thumb data
for i = 1:height(unfiltered_data) 
unfiltered_data.thumbvelocity{i,1} = unfiltered_data.ThumbTrials{i,1}(:,[1,4]);%Velocity
unfiltered_data.thumbaccel{i,1} = unfiltered_data.ThumbTrials{i,1}(:,[1,5]); %Accel
unfiltered_data.thumbXYposn{i,1} = unfiltered_data.ThumbTrials{i,1}(:,[2,3]); %X/Y Posn
%Strip index data
unfiltered_data.indexvelocity{i,1} = unfiltered_data.IndexTrials{i,1}(:,[1,4]);%Velocity
unfiltered_data.indexaccel{i,1} = unfiltered_data.IndexTrials{i,1}(:,[1,5]); %Accel
unfiltered_data.indexXYposn{i,1} = unfiltered_data.IndexTrials{i,1}(:,[2,3]); %X/Y Posn
end
%Remove redundant columns
unfiltered_data.ThumbTrials = [];
unfiltered_data.IndexTrials = [];

%------------Normalisation------------%
%Normalize time data into a percentage from 0-100
%This is required to generate average curves but total time will still be
%available for analysis
for i = 1:height(unfiltered_data) 
unfiltered_data.MgaTrials{i,1}(:,1) = normalize_var(unfiltered_data.MgaTrials{i,1}(:,1),0,100);
unfiltered_data.thumbvelocity{i,1}(:,1) = normalize_var(unfiltered_data.thumbvelocity{i,1}(:,1),0,100);
unfiltered_data.indexvelocity{i,1}(:,1) = normalize_var(unfiltered_data.indexvelocity{i,1}(:,1),0,100);
unfiltered_data.thumbaccel{i,1}(:,1) = normalize_var(unfiltered_data.thumbaccel{i,1}(:,1),0,100);
unfiltered_data.indexaccel{i,1}(:,1) = normalize_var(unfiltered_data.indexaccel{i,1}(:,1),0,100);
end

%------------Noise Filtering------------%
%2nd order dual pass low butterworth filter to smooth the data.
%To account for the NaNs in velocity and accel readouts
%use (2:end-1,2)and (3:end-2,2) resepectively when indexing
%otherwise just use (:,2) for mga trials

sf = 240; %sample freq = 240 (frame rate)
cf = 10; %cutoff freq = 10 (from journals)
[b,a] = butter(1,cf/(sf/2)); 
filtered_data = unfiltered_data;
for i = 1:height(filtered_data) 
filtered_data.thumbvelocity{i,1}(2:end-1,2) = filtfilt(b,a,filtered_data.thumbvelocity{i,1}(2:end-1,2));
filtered_data.indexvelocity{i,1}(2:end-1,2) = filtfilt(b,a,filtered_data.indexvelocity{i,1}(2:end-1,2));
filtered_data.MgaTrials{i,1}(:,2) = filtfilt(b,a,filtered_data.MgaTrials{i,1}(:,2));
filtered_data.thumbaccel{i,1}(3:end-2,2) = filtfilt(b,a,filtered_data.thumbaccel{i,1}(3:end-2,2));
filtered_data.indexaccel{i,1}(3:end-2,2) = filtfilt(b,a,filtered_data.indexaccel{i,1}(3:end-2,2));
end

%Loops through each table to enter in MGA, mVelocity and time to each (%)
% from each trial (row) 
nfiles = height(filtered_data);
sec_frame = 1/240; %seconds per frame
for i = 1:nfiles

%------------Total Time-------------%
filtered_data.totaltime(i)= (size(filtered_data.MgaTrials{i,1}(:,1),1)*sec_frame*1000);

%------------MGA------------%
[filtered_data.mMGA(i), filtered_data.mMGAFrame(i)] = max(filtered_data.MgaTrials{i,1}(:,2)); %find mMGA/frame
%a and b corrospond to filling T2MGA trials
a = find(filtered_data.MgaTrials{i,1}(:,2)== max(filtered_data.MgaTrials{i,1}(:,2)));
b = length(filtered_data.MgaTrials{i,1}(:,2));
filtered_data.T2mMGA_pcnt(i) = a/b*100; %time 2 peak(%)
filtered_data.T2mMGA_ms(i) = filtered_data.mMGAFrame(i)*sec_frame*1000; %time to peak (ms) 
filtered_data.mMGA2end_ms(i) = filtered_data.totaltime(i) - filtered_data.T2mMGA_ms(i); %Peak to end (ms) 
filtered_data.mMGA2end_pcnt(i) = 100 - filtered_data.T2mMGA_pcnt(i); %Peak to end (%)

%------------Velocity------------%
%For thumb
[filtered_data.thumb_mVeloc(i), filtered_data.thumb_mVelocFrame(i)] = max(filtered_data.thumbvelocity{i,1}(:,2)); %find mVelocity/frame
%c and d corrospond to filling T2velocity trials
c = find(filtered_data.thumbvelocity{i,1}(:,2)== max(filtered_data.thumbvelocity{i,1}(:,2)));
d = length(filtered_data.thumbvelocity{i,1}(:,2));
filtered_data.thumb_T2mVeloc_pcnt(i) = c/d*100; %time to peak (%)
filtered_data.thumb_T2mVeloc_ms(i) = filtered_data.thumb_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
filtered_data.thumb_mVeloc2end_ms(i) = filtered_data.totaltime(i) - filtered_data.thumb_T2mVeloc_ms(i); %Peak to end (ms)
filtered_data.thumb_mVeloc2end_pcnt(i) = 100 - filtered_data.thumb_T2mVeloc_pcnt(i); %Peak to end (%)

%For index 
[filtered_data.index_mVeloc(i), filtered_data.index_mVelocFrame(i)] = max(filtered_data.indexvelocity{i,1}(:,2)); %find mVelocity/frame

%c and d corrospond to filling T2velocity trials
cc = find(filtered_data.indexvelocity{i,1}(:,2)== max(filtered_data.indexvelocity{i,1}(:,2)));
dd = length(filtered_data.indexvelocity{i,1}(:,2));
filtered_data.index_T2mVeloc_pcnt(i) = cc/dd*100; %time to peak (%)
filtered_data.index_T2mVeloc_ms(i) = filtered_data.index_mVelocFrame(i)*sec_frame*1000; %time to peak (ms) 
filtered_data.index_mVeloc2end_ms(i) = filtered_data.totaltime(i) - filtered_data.index_T2mVeloc_ms(i); %Peak to end (ms)
filtered_data.index_mVeloc2end_pcnt(i) = 100 - filtered_data.index_T2mVeloc_pcnt(i); %Peak to end (%)


%------------Acceleration-------------------
%Thumb
[filtered_data.thumb_mAccel(i), filtered_data.thumb_mAccelFrame(i)] = max(filtered_data.thumbaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials

e = find(filtered_data.thumbaccel{i,1}(:,2)== max(filtered_data.thumbaccel{i,1}(:,2)));
f = length(filtered_data.thumbaccel{i,1}(:,2));
filtered_data.thumb_T2mAccel_pcnt(i) = e/f*100; %time to peak (%)
filtered_data.thumb_T2mAccel_ms(i) = filtered_data.thumb_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
filtered_data.thumb_mAccel2end_ms(i) = filtered_data.totaltime(i) - filtered_data.thumb_T2mAccel_ms(i); %peak to end (ms)
filtered_data.thumb_mAccel2end_pcnt(i) = 100 - filtered_data.thumb_T2mAccel_pcnt(i); %peak to end (%)


%Index
[filtered_data.index_mAccel(i), filtered_data.index_mAccelFrame(i)] = max(filtered_data.indexaccel{i,1}(:,2)); %find mAccel
%e and f corrospond to filling T2velocity trials

ee = find(filtered_data.indexaccel{i,1}(:,2)== max(filtered_data.indexaccel{i,1}(:,2)));
ff = length(filtered_data.indexaccel{i,1}(:,2));
filtered_data.index_T2mAccel_pcnt(i) = ee/ff*100; %time to peak (%)
filtered_data.index_T2mAccel_ms(i) = filtered_data.index_mAccelFrame(i)*sec_frame*1000; %time to peak (ms) 
filtered_data.index_mAccel2end_ms(i) = filtered_data.totaltime(i) - filtered_data.index_T2mAccel_ms(i); %peak to end (ms)
filtered_data.index_mAccel2end_pcnt(i) = 100 - filtered_data.index_T2mAccel_pcnt(i); %peak to end (%)
end
%remove unnecessary columns after calc 
filtered_data.thumb_mVelocFrame = [];
filtered_data.index_mVelocFrame = []; 
filtered_data.thumb_mAccelFrame = []; 
filtered_data.index_mAccelFrame = [];
filtered_data.mMGAFrame = [];
end 