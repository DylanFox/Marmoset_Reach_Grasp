%Dependecies - permutationTest.m
%Couldn't find a way so before calling this function let Parameter =
%MasterData.MGA or any of the columns you are interested in. 

function [T_p,T_e] = Permutation_PlotData(MasterData,Parameter,AllPredictors)

Dummy_Var = zeros(height(MasterData),1);

%Parameter = AllPredictors.Parameter; 
for i = 1:height(MasterData)
    if MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left' 
        Dummy_Var(i,1) = 1; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 2; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 3; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 4;
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 5; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 6;
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 7; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 8; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 9; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 10;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 11; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 12;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 13; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        Dummy_Var(i,1) = 14;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        Dummy_Var(i,1) = 15;
    else
        Dummy_Var(i,1) = 16;
    end 
end

E = categorical(Dummy_Var, [1:16], {'ECSL','ECSR','ECLL','ECLR','ELSL','ELSR','ELLL','ELLR','VCSL','VCSR','VCLL','VCLR','VLSL','VLSR','VLLL','VLLR'});
AllPredictors.ExpCohortFoodHand = E;


T_p = table(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
T_e = table(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
T_p.Properties.VariableNames = {'ECSL','ECSR','ECLL','ECLR','ELSL','ELSR','ELLL','ELLR','VCSL','VCSR','VCLL','VCLR','VLSL','VLSR','VLLL','VLLR'};
T_e.Properties.VariableNames = {'ECSL','ECSR','ECLL','ECLR','ELSL','ELSR','ELLL','ELLR','VCSL','VCSR','VCLL','VCLR','VLSL','VLSR','VLLL','VLLR'};
[T_p.ECSL(1),~,T_e.ECSL(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='ECSL'),Parameter(AllPredictors.ExpCohortFoodHand =='ELSL'),10000,'plotresult',1);
[T_p.ECSR(1),~,T_e.ECSR(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='ECSR'),Parameter(AllPredictors.ExpCohortFoodHand =='ELSR'),10000,'plotresult',1);
[T_p.ECLL(1),~,T_e.ECLL(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='ECLL'),Parameter(AllPredictors.ExpCohortFoodHand =='ELLL'),10000,'plotresult',1);
[T_p.ECLR(1),~,T_e.ECLR(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='ECLR'),Parameter(AllPredictors.ExpCohortFoodHand =='ELLR'),10000,'plotresult',1);
[T_p.VCSL(1),~,T_e.VCSL(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='VCSL'),Parameter(AllPredictors.ExpCohortFoodHand =='VLSL'),10000,'plotresult',1);
[T_p.VCSR(1),~,T_e.VCSR(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='VCSR'),Parameter(AllPredictors.ExpCohortFoodHand =='VLSR'),10000,'plotresult',1);
[T_p.VCLL(1),~,T_e.VCLL(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='VCLL'),Parameter(AllPredictors.ExpCohortFoodHand =='VLLL'),10000,'plotresult',1);
[T_p.VCLR(1),~,T_e.VCLR(1)] = permutationTest(Parameter(AllPredictors.ExpCohortFoodHand =='VCLR'),Parameter(AllPredictors.ExpCohortFoodHand =='VLLR'),10000,'plotresult',1);
end

