TestData = zeros(height(MasterData),1);
for i = 1:height(MasterData)
    if MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left' 
        TestData(i,1) = 1; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 2; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 3; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 4;
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 5; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 6;
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 7; 
    elseif MasterData.Experiment(i) == 'Efron' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 8; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 9; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 10;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 11; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Control' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 12;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 13; 
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Small' && MasterData.HandUse(i) == 'Right'
        TestData(i,1) = 14;
    elseif MasterData.Experiment(i) == 'Volume' && MasterData.Cohort(i) == 'Lesion' && MasterData.FoodSize(i) == 'Large' && MasterData.HandUse(i) == 'Left'
        TestData(i,1) = 15;
    else
        TestData(i,1) = 16;
    end 
end