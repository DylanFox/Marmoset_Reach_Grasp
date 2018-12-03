%Converting main dataset into invidivual elements of interest 
 PermuteData = zeros(height(MasterData),2); 
for i = 1:height(MasterData)
    if MasterData.Experiment(i) == 'Efron' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left' 
        PermuteData(i,1) = 1; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        PermuteData(i,1) = 2; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        PermuteData(i,1) = 3; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        PermuteData(i,1) = 4;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        PermuteData(i,1) = 5; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        PermuteData(i,1) = 6;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        PermuteData(i,1) = 7; 
    else
        PermuteData(i,1) = 8;
    end
end

PermuteData(:,[2:14]) = table2array(AllPredictors(:,[3:15]));

cntrlidx = MasterData.Cohort == 'Control';

cntrlData = PermuteData(cntrlidx,:);
lesionData = PermuteData(~cntrlidx,:);


%These help index into the conditions Experiment (2) * Foodsize(2) *
%Hand(2) = 8 Conditions.  ESL, ESR, ELL, ELR, VSL, VSR, VLL, VLR
ctrlidx1 = cntrlidx(PermuteData(:,1)==1);
ctrlidx2 = cntrlidx(PermuteData(:,1)==2);
ctrlidx3 = cntrlidx(PermuteData(:,1)==3);
ctrlidx4 = cntrlidx(PermuteData(:,1)==4);
ctrlidx5 = cntrlidx(PermuteData(:,1)==5);
ctrlidx6 = cntrlidx(PermuteData(:,1)==6);
ctrlidx7 = cntrlidx(PermuteData(:,1)==7);
ctrlidx8 = cntrlidx(PermuteData(:,1)==8);

lsnidx1 = ~cntrlidx(PermuteData(:,1)==1);
lsnidx2 = ~cntrlidx(PermuteData(:,1)==2);
lsnidx3 = ~cntrlidx(PermuteData(:,1)==3);
lsnidx4 = ~cntrlidx(PermuteData(:,1)==4);
lsnidx5 = ~cntrlidx(PermuteData(:,1)==5);
lsnidx6 = ~cntrlidx(PermuteData(:,1)==6);
lsnidx7 = ~cntrlidx(PermuteData(:,1)==7);
lsnidx8 = ~cntrlidx(PermuteData(:,1)==8);

%% Making P table for permutation comparisons  
%Row one will output differences BETWEEN Control and Lesion
%Row two will output differences WITHIN Control
%Row three will output differences WITHIN Lesion
T2MGA_ms_perm_pvalues = table(0,0,0,0,0,0,0,0); 
T2MGA_ms_perm_pvalues.Properties.VariableNames = {'EfronSmallLeft' 'EfronSmallRight' 'EfronLargeLeft' 'EfronLargeRight' 'VolumeSmallLeft' 'VolumeSmallRight' 'VolumeLargeLeft' 'VolumeLargeRight'};

T2MGA_ms_perm_obsdiff = table(0,0,0,0,0,0,0,0);
T2MGA_ms_perm_obsdiff.Properties.VariableNames = {'EfronSmallLeft' 'EfronSmallRight' 'EfronLargeLeft' 'EfronLargeRight' 'VolumeSmallLeft' 'VolumeSmallRight' 'VolumeLargeLeft' 'VolumeLargeRight'};

T2MGA_ms_perm_effectsize = table(0,0,0,0,0,0,0,0);
T2MGA_ms_perm_effectsize.Properties.VariableNames = {'EfronSmallLeft' 'EfronSmallRight' 'EfronLargeLeft' 'EfronLargeRight' 'VolumeSmallLeft' 'VolumeSmallRight' 'VolumeLargeLeft' 'VolumeLargeRight'};

[T2MGA_ms_perm_pvalues.EfronSmallLeft(1), T2MGA_ms_perm_obsdiff.EfronSmallLeft(1),T2MGA_ms_perm_effectsize.EfronSmallLeft(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx1),AllPredictors.T2MGA_ms(lsnidx1),10000);
[T2MGA_ms_perm_pvalues.EfronSmallRight(1), T2MGA_ms_perm_obsdiff.EfronSmallRight(1),T2MGA_ms_perm_effectsize.EfronSmallRight(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx2),AllPredictors.T2MGA_ms(lsnidx2),10000);
[T2MGA_ms_perm_pvalues.EfronLargeLeft(1), T2MGA_ms_perm_obsdiff.EfronLargeLeft(1),T2MGA_ms_perm_effectsize.EfronLargeLeft(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx3),AllPredictors.T2MGA_ms(lsnidx3),10000);
[T2MGA_ms_perm_pvalues.EfronLargeRight(1), T2MGA_ms_perm_obsdiff.EfronLargeRight(1),T2MGA_ms_perm_effectsize.EfronLargeRight(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx4),AllPredictors.T2MGA_ms(lsnidx4),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallLeft(1), T2MGA_ms_perm_obsdiff.VolumeSmallLeft(1),T2MGA_ms_perm_effectsize.VolumeSmallLeft(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx5),AllPredictors.T2MGA_ms(lsnidx5),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallRight(1), T2MGA_ms_perm_obsdiff.VolumeSmallRight(1),T2MGA_ms_perm_effectsize.VolumeSmallRight(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx6),AllPredictors.T2MGA_ms(lsnidx6),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeLeft(1), T2MGA_ms_perm_obsdiff.VolumeLargeLeft(1),T2MGA_ms_perm_effectsize.VolumeLargeLeft(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx7),AllPredictors.T2MGA_ms(lsnidx7),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeRight(1), T2MGA_ms_perm_obsdiff.VolumeLargeRight(1),T2MGA_ms_perm_effectsize.VolumeLargeRight(1)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx8),AllPredictors.T2MGA_ms(lsnidx8),10000);

[T2MGA_ms_perm_pvalues.EfronSmallLeft(2), T2MGA_ms_perm_obsdiff.EfronSmallLeft(2),T2MGA_ms_perm_effectsize.EfronSmallLeft(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx1),AllPredictors.T2MGA_ms(ctrlidx2),10000);
[T2MGA_ms_perm_pvalues.EfronSmallRight(2),T2MGA_ms_perm_obsdiff.EfronSmallRight(2),T2MGA_ms_perm_effectsize.EfronSmallRight(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx1),AllPredictors.T2MGA_ms(ctrlidx3),10000);
[T2MGA_ms_perm_pvalues.EfronLargeLeft(2), T2MGA_ms_perm_obsdiff.EfronLargeLeft(2),T2MGA_ms_perm_effectsize.EfronLargeLeft(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx2),AllPredictors.T2MGA_ms(ctrlidx4),10000);
[T2MGA_ms_perm_pvalues.EfronLargeRight(2), T2MGA_ms_perm_obsdiff.EfronLargeRight(2),T2MGA_ms_perm_effectsize.EfronLargeRight(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx3),AllPredictors.T2MGA_ms(ctrlidx4),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallLeft(2), T2MGA_ms_perm_obsdiff.VolumeSmallLeft(2),T2MGA_ms_perm_effectsize.VolumeSmallLeft(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx5),AllPredictors.T2MGA_ms(ctrlidx6),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallRight(2), T2MGA_ms_perm_obsdiff.VolumeSmallRight(2),T2MGA_ms_perm_effectsize.VolumeSmallRight(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx5),AllPredictors.T2MGA_ms(ctrlidx7),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeLeft(2),T2MGA_ms_perm_obsdiff.VolumeLargeLeft(2),T2MGA_ms_perm_effectsize.VolumeLargeLeft(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx6),AllPredictors.T2MGA_ms(ctrlidx8),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeRight(2), T2MGA_ms_perm_obsdiff.VolumeLargeRight(2),T2MGA_ms_perm_effectsize.VolumeLargeRight(2)] = permutationTest(AllPredictors.T2MGA_ms(ctrlidx7),AllPredictors.T2MGA_ms(ctrlidx8),10000);

[T2MGA_ms_perm_pvalues.EfronSmallLeft(3), T2MGA_ms_perm_obsdiff.EfronSmallLeft(3),T2MGA_ms_perm_effectsize.EfronSmallLeft(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx1),AllPredictors.T2MGA_ms(lsnidx2),10000);
[T2MGA_ms_perm_pvalues.EfronSmallRight(3), T2MGA_ms_perm_obsdiff.EfronSmallRight(3),T2MGA_ms_perm_effectsize.EfronSmallRight(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx1),AllPredictors.T2MGA_ms(lsnidx3),10000);
[T2MGA_ms_perm_pvalues.EfronLargeLeft(3), T2MGA_ms_perm_obsdiff.EfronLargeLeft(3),T2MGA_ms_perm_effectsize.EfronLargeLeft(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx2),AllPredictors.T2MGA_ms(lsnidx4),10000);
[T2MGA_ms_perm_pvalues.EfronLargeRight(3), T2MGA_ms_perm_obsdiff.EfronLargeRight(3),T2MGA_ms_perm_effectsize.EfronLargeRight(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx3),AllPredictors.T2MGA_ms(lsnidx4),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallLeft(3), T2MGA_ms_perm_obsdiff.VolumeSmallLeft(3),T2MGA_ms_perm_effectsize.VolumeSmallLeft(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx5),AllPredictors.T2MGA_ms(lsnidx6),10000);
[T2MGA_ms_perm_pvalues.VolumeSmallRight(3), T2MGA_ms_perm_obsdiff.VolumeSmallRight(3),T2MGA_ms_perm_effectsize.VolumeSmallRight(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx5),AllPredictors.T2MGA_ms(lsnidx7),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeLeft(3), T2MGA_ms_perm_obsdiff.VolumeLargeLeft(3),T2MGA_ms_perm_effectsize.VolumeLargeLeft(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx6),AllPredictors.T2MGA_ms(lsnidx8),10000);
[T2MGA_ms_perm_pvalues.VolumeLargeRight(3), T2MGA_ms_perm_obsdiff.VolumeLargeRight(3),T2MGA_ms_perm_effectsize.VolumeLargeRight(3)] = permutationTest(AllPredictors.T2MGA_ms(lsnidx7),AllPredictors.T2MGA_ms(lsnidx8),10000);