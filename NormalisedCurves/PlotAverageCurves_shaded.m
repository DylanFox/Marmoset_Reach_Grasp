 %This script is used to normalise prehensile profiles into percentages and
%then generate an average curve for each group for qualitative comparisons 
% Dependencies - shadedErrorBar, DataPrep_ErrorShade 

% Notes: Square root numbers can be changed to the length/# of trials - this used
% to calculate SEM 
%% Normalise trial data onto 100 points to represent a percentage of the prehensile movement 
timei = linspace(0,100);
for i = 1:height(MasterData)
MasterData.mgainterp{i} = interp1(MasterData.Mgatrials{i}(:,1),MasterData.Mgatrials{i}(:,2),timei(:),'linear','extrap');
MasterData.velocinterp{i} = interp1(MasterData.thumbvelocity{i}(2:end-1,1),MasterData.thumbvelocity{i}(2:end-1,2),timei(:),'linear','extrap');
MasterData.accelinterp{i} = interp1(MasterData.thumbaccel{i}(3:end-2,1),MasterData.thumbaccel{i}(3:end-2,2),timei(:),'linear','extrap');
end

%% Set up variables for plotting Experiment 1 (Efron) 
MGA_ECL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Left',:);
MGA_ECR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Right',:);
MGA_ELL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Left',:);
MGA_ELR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Right',:);

MGA_ECL_mat = DataPrep_ErrorShade(MGA_ECL);
MGA_ECR_mat = DataPrep_ErrorShade(MGA_ECR);
MGA_ELL_mat = DataPrep_ErrorShade(MGA_ELL);
MGA_ELR_mat = DataPrep_ErrorShade(MGA_ELR);

Veloc_ECL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Efron Control Left',:);
Veloc_ECR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Efron Control Right',:);
Veloc_ELL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Efron Lesion Left',:);
Veloc_ELR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Efron Lesion Right',:);

Veloc_ECL_mat = DataPrep_ErrorShade(Veloc_ECL);
Veloc_ECR_mat = DataPrep_ErrorShade(Veloc_ECR);
Veloc_ELL_mat = DataPrep_ErrorShade(Veloc_ELL);
Veloc_ELR_mat = DataPrep_ErrorShade(Veloc_ELR);

Accel_ECL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Efron Control Left',:);
Accel_ECR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Efron Control Right',:);
Accel_ELL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Efron Lesion Left',:);
Accel_ELR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Efron Lesion Right',:);

Accel_ECL_mat = DataPrep_ErrorShade(Accel_ECL);
Accel_ECR_mat = DataPrep_ErrorShade(Accel_ECR);
Accel_ELL_mat = DataPrep_ErrorShade(Accel_ELL);
Accel_ELR_mat = DataPrep_ErrorShade(Accel_ELR);

%% Plot Experiment 1 (Efron) profiles
%Plot grip aperture profiles
figure;
shadedErrorBar(timei,mean(MGA_ECL_mat,1),std(MGA_ECL_mat)/sqrt(90),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(MGA_ECR_mat,1),std(MGA_ECR_mat)/sqrt(78),'lineprops','r');
shadedErrorBar(timei,mean(MGA_ELL_mat,1),std(MGA_ELL_mat)/sqrt(86),'lineprops','g');
shadedErrorBar(timei,mean(MGA_ELR_mat,1),std(MGA_ELR_mat)/sqrt(86),'lineprops','k');

%% Set up variables for plotting Experiment 2 
MGA_VCL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
MGA_VCR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
MGA_VLL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
MGA_VLR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);

MGA_VCL_mat = DataPrep_ErrorShade(MGA_ECL);
MGA_VCR_mat = DataPrep_ErrorShade(MGA_ECR);
MGA_VLL_mat = DataPrep_ErrorShade(MGA_ELL);
MGA_VLR_mat = DataPrep_ErrorShade(MGA_ELR);

Veloc_VCL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
Veloc_VCR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
Veloc_VLL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
Veloc_VLR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);

Veloc_VCL_mat = DataPrep_ErrorShade(Veloc_VCL);
Veloc_VCR_mat = DataPrep_ErrorShade(Veloc_VCR);
Veloc_VLL_mat = DataPrep_ErrorShade(Veloc_VLL);
Veloc_VLR_mat = DataPrep_ErrorShade(Veloc_VLR);

Accel_VCL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
Accel_VCR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
Accel_VLL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
Accel_VLR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);

Accel_VCL_mat = DataPrep_ErrorShade(Accel_VCL);
Accel_VCR_mat = DataPrep_ErrorShade(Accel_VCR);
Accel_VLL_mat = DataPrep_ErrorShade(Accel_VLL);
Accel_VLR_mat = DataPrep_ErrorShade(Accel_VLR);

%% Plot Experiment 2 (volume) profiles
%Plot Grip Aperture profiles
figure;
shadedErrorBar(timei,mean(MGA_VCL_mat,1),std(MGA_VCL_mat)/sqrt(90),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(MGA_VCR_mat,1),std(MGA_VCR_mat)/sqrt(78),'lineprops','r');
shadedErrorBar(timei,mean(MGA_VLL_mat,1),std(MGA_VLL_mat)/sqrt(86),'lineprops','g');
shadedErrorBar(timei,mean(MGA_VLR_mat,1),std(MGA_VLR_mat)/sqrt(86),'lineprops','k');

%Plot Velocity profiles
figure;
shadedErrorBar(timei,mean(Veloc_VCL_mat,1),std(Veloc_VCL_mat)/sqrt(123),'lineprops','b');
hold on
shadedErrorBar(timei,mean(Veloc_VCR_mat,1),std(Veloc_VCR_mat)/sqrt(107),'lineprops','r');
shadedErrorBar(timei,mean(Veloc_VLL_mat,1),std(Veloc_VLL_mat)/sqrt(88),'lineprops','g');
shadedErrorBar(timei,mean(Veloc_VLR_mat,1),std(Veloc_VLR_mat)/sqrt(91),'lineprops','k');

%Plot Acceleration profiles
figure;
shadedErrorBar(timei,mean(Accel_VCL_mat,1),std(Accel_VCL_mat)/sqrt(123),'lineprops','b');
hold on
shadedErrorBar(timei,mean(Accel_VCR_mat,1),std(Accel_VCR_mat)/sqrt(107),'lineprops','r');
shadedErrorBar(timei,mean(Accel_VLL_mat,1),std(Accel_VLL_mat)/sqrt(88),'lineprops','g');
shadedErrorBar(timei,mean(Accel_VLR_mat,1),std(Accel_VLR_mat)/sqrt(91),'lineprops','k');