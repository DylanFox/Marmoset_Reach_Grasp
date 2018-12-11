%% Permutation Analysis to produce P values and effect sizes
%Generate permutation distributions - can turn plotting off in
%Permutation_PlotData.m file if not required
Parameter = MasterData.T2mVeloc_ms;
[T2mVelocms_p,T2mVelocms_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.totaltime;
[totaltime_p,totaltime_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.mVeloc;
[mVeloc_p,mVeloc_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.T2mVeloc_pcnt;
[T2mVeloc_pcnt_p,T2mVeloc_pcnt_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.mAccel;
[mAccel_p,mAccel_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.T2mAccel_pcnt;
[T2mAccel_pcnt_p,T2mAccel_pcnt_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.T2mAccel_ms;
[T2mAccel_ms_p,T2mAccel_ms_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.AverageSpeed;
[AverageSpeed_p,AverageSpeed_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.AverageAccel;
[AverageAccel_p,AverageAccel_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.MGA;
[MGA_p,MGA_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.T2MGA_ms;
[T2MGA_ms_p,T2MGA_ms_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.T2MGA_pcnt;
[T2MGA_pcnt_p,T2MGA_pcnt_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);
Parameter = MasterData.AverageMGA;
[AverageMGA_p,AverageMGA_eff] = Permutation_Heatmap(MasterData,Parameter,AllPredictors);

%% Data Prep for Heatmaps
%Concatenate all p values and effect sizes into one table 
AllParam_p = vertcat(totaltime_p,mVeloc_p,T2mVelocms_p,T2mVeloc_pcnt_p,mAccel_p,T2mAccel_ms_p,T2mAccel_pcnt_p,AverageSpeed_p,AverageAccel_p,MGA_p,T2MGA_ms_p,T2MGA_pcnt_p,AverageMGA_p);
AllParam_eff = vertcat(totaltime_eff,mVeloc_eff,T2mVelocms_eff,T2mVeloc_pcnt_eff,mAccel_eff,T2mAccel_ms_eff,T2mAccel_pcnt_eff,AverageSpeed_eff,AverageAccel_eff,MGA_eff,T2MGA_ms_eff,T2MGA_pcnt_eff,AverageMGA_eff);

%Remove blank columns
AllParam_p(:,{'ELSL','ELSR','ELLL','ELLR','VLSL','VLSR','VLLL','VLLR'}) = [];
AllParam_eff(:,{'ELSL','ELSR','ELLL','ELLR','VLSL','VLSR','VLLL','VLLR'}) = [];

%For heatmap plots with this dataset I found it easier to work with a
%matrix so tables were converted 
pData = table2cell(AllParam_p); pData = cell2mat(pData);
effData = table2cell(AllParam_eff); effData = cell2mat(effData);

XVar = {'Efron - Small Left', 'Efron - Small Right', 'Efron - Large Left', 'Efron - Large Right', 'Volume - Small Left', 'Volume - Small Right', 'Volume - Large Left', 'Volume - Large Right'};
YVar = {'Total Time (ms)', 'Max Velocity (mm/s)', 'Time to Max Velocity (ms)', 'Time to Max Velocity (%)', 'Max Acceleration (mm s-2)', 'Time to Max Acceleration (ms)','Time to Max Acceleration (%)','Average Velocity (mm/s)','Average Acceleration (mm s-2)','MGA (mm)','Time to MGA (ms)','Time to MGA (%)','Average Grip Aperture (mm)'};

%% Plot Heatmaps 
%Plot p heatmap
figure; p_heatmap = heatmap(XVar,YVar,pData);
p_heatmap.CellLabelFormat = '%.4f';
p_heatmap.FontName = 'sans serif';
p_heatmap.ColorLimits = [0.0001 0.1];

%Plot effect size heatmap 
figure; eff_heatmap = heatmap(XVar,YVar,effData);
eff_heatmap.CellLabelFormat = '%.2f';
eff_heatmap.FontName = 'sans serif';
eff_heatmap.ColorLimits = [-2 2];
    %Create 64x3 colour map from blue - white - red
    y1a = linspace(0,1,32);
    y1b = linspace(1,0,32);
    y2a = linspace(0.45,1,32);
    y2b = linspace(1,0,32);
    y3a = linspace(0.74,1,32);
    y3b = linspace(1,0,32);
    y1a = y1a';
    y1b = y1b';
    y2a = y2a';
    y2b = y2b';
    y3a = y3a';
    y3b = y3b';
    y1 = vertcat(y1a,y1b);
    y2 = vertcat(y2a,y2b);
    y3 = vertcat(y3a,y3b);
    Colour_map_eff = horzcat(y1,y2,y3); 
    %Remove the double up of a row at white (row 32 and 33)
    Colour_map_eff(33:end,1) = linspace(0.94,1,32);
    Colour_map_eff(32:end,2) = linspace(1,0,33);
    Colour_map_eff(32:end,3) = linspace(1,0,33);
 %Add to plot
 eff_heatmap.Colormap = Colour_map_eff;
%% 






