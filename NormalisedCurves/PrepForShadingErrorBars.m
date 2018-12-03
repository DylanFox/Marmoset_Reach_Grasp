
%Prepping data for shaded area bars!!! 
timei = linspace(0,100);
for i = 1:height(MasterData)
MasterData.mgainterp{i} = interp1(MasterData.Mgatrials{i}(:,1),MasterData.Mgatrials{i}(:,2),timei(:),'linear','extrap');
MasterData.velocinterp{i} = interp1(MasterData.thumbvelocity{i}(2:end-1,1),MasterData.thumbvelocity{i}(2:end-1,2),timei(:),'linear','extrap');
MasterData.accelinterp{i} = interp1(MasterData.thumbaccel{i}(3:end-2,1),MasterData.thumbaccel{i}(3:end-2,2),timei(:),'linear','extrap');
end
y_mean = mean([MasterData.mgainterp{:}],2);
a = horzcat(MasterData.mgainterp(:));
a = cell2mat(a);
a = reshape(a,100,772);
a = a';
H = shadedErrorBar(timei,mean(a,1),std(a)/sqrt(772),'lineprops','g');


MGA_ECL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Left',:);
MGA_ECR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Right',:);
MGA_ELL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Left',:);
MGA_ELR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Right',:);

MGA_ECL_mat = horzcat(MGA_ECL);
MGA_ECL_mat = cell2mat(MGA_ECL_mat);
MGA_ECL_mat = reshape(MGA_ECL_mat,100,:);
MGA_ECL_mat = MGA_ECL_mat' 
 

shadedErrorBar(timei,mean(MGA_ECL_mat,1),std(MGA_ECL_mat)/sqrt(90),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(MGA_ECR_mat,1),std(MGA_ECR_mat)/sqrt(78),'lineprops','r');
shadedErrorBar(timei,mean(MGA_ELL_mat,1),std(MGA_ELL_mat)/sqrt(86),'lineprops','g');
shadedErrorBar(timei,mean(MGA_ELR_mat,1),std(MGA_ELR_mat)/sqrt(86),'lineprops','k');


MGA_VCL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
MGA_VCR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
MGA_VLL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
MGA_VLR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);

MGA_ECL_mat = horzcat(MGA_ECL);
MGA_ECL_mat = cell2mat(MGA_ECL_mat);
MGA_ECL_mat = reshape(MGA_ECL_mat,100,:);
MGA_ECL_mat = MGA_ECL_mat'


Veloc_VCL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
Veloc_VCR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
Veloc_VLL = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
Veloc_VLR = MasterData.velocinterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);

Accel_VCL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Control Left',:);
Accel_VCR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Control Right',:);
Accel_VLL = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Lesion Left',:);
Accel_VLR = MasterData.accelinterp(MasterData.ExpCohortHand == 'Volume Lesion Right',:);


Veloc_VCL_mat = DataPrepforErrorShade(Veloc_VCL);
Veloc_VCR_mat = DataPrepforErrorShade(Veloc_VCR);
Veloc_VLL_mat = DataPrepforErrorShade(Veloc_VLL);
Veloc_VLR_mat = DataPrepforErrorShade(Veloc_VLR);
Accel_VCL_mat = DataPrepforErrorShade(Accel_VCL);
Accel_VCR_mat = DataPrepforErrorShade(Accel_VCR);
Accel_VLL_mat = DataPrepforErrorShade(Accel_VLL);
Accel_VLR_mat = DataPrepforErrorShade(Accel_VLR);

figure;
shadedErrorBar(timei,mean(Veloc_VCL_mat,1),std(Veloc_VCL_mat)/sqrt(123),'lineprops','b');
hold on
shadedErrorBar(timei,mean(Veloc_VCR_mat,1),std(Veloc_VCR_mat)/sqrt(107),'lineprops','r');
shadedErrorBar(timei,mean(Veloc_VLL_mat,1),std(Veloc_VLL_mat)/sqrt(88),'lineprops','g');
shadedErrorBar(timei,mean(Veloc_VLR_mat,1),std(Veloc_VLR_mat)/sqrt(91),'lineprops','k');

figure;
shadedErrorBar(timei,mean(Accel_VCL_mat,1),std(Accel_VCL_mat)/sqrt(123),'lineprops','b');
hold on
shadedErrorBar(timei,mean(Accel_VCR_mat,1),std(Accel_VCR_mat)/sqrt(107),'lineprops','r');
shadedErrorBar(timei,mean(Accel_VLL_mat,1),std(Accel_VLL_mat)/sqrt(88),'lineprops','g');
shadedErrorBar(timei,mean(Accel_VLR_mat,1),std(Accel_VLR_mat)/sqrt(91),'lineprops','k');