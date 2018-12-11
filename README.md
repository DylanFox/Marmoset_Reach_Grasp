# Marmoset Reach and Grasp Kinematics 

Code base for the processing and visualisation of kinematic data used during part of my PhD project. It should be noted that the program used in this project was created solely to meet the needs of importing kinematic data and analysing it. It is not fully optimised or flexible to different approaches. For best results, please follow the steps shown below. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Current status of readme 

This readme as of 10/12/18 remains under development. I aim to streamline this process as much as possible, some files will be removed over the next week and reorganised in a (hopefully) simple to follow format. 

### Prerequisites

[Tracker](https://physlets.org/tracker/) - Software for adding ROI to videos and measuring their trajectories, angles, distance to other ROIs, etc. This software is free and comes with tutorials and test videos to learn with. 

[MATLAB](https://au.mathworks.com/products/matlab.html) - I have used this with all versions from MATLAB 2015b-2017b. 

**Ensure all folders and subfolders are added to the directory path**

## Running the codes from data import to visualisation

Explain how to sequence of events - Use example of getting some data out of the system or using it for a little demo

### Stage 1 - Data import 

This stage imports .txt files generated from tracker into the MATLAB environment. Follow the comments in the ImportData.m to ensure the files are named corrected and are within the current directory. Data is also filtered through a 2nd order dual pass butterworth filter with 10hz low pass cut-off frequency. Data is also stripped further into parameters such as peak velocity and time taken to reach the peak. Raw and smoothed data are stored separately.  

```
[raw_data, filtered_data] = ImportData;
```

### Stage 2 - Data Analysis and Visualisation 

For demo purposes you can use MasterData.mat to analysis/visualise otherwise rename your dataset to MasterData for convenience as some of these rely on scripts rather than dedicated functions.  

#### Heatmaps 

Here we generate heatmaps for each parameter measured (e.g. max velocity) based on the p-values and effect sizes obtained from a permutation analysis comparing experimental conditions (e.g. control v.s. lesioned or left v.s. right hand). Using example data given just running Generate_Heatmaps.m will provide you with the heatmaps produced in this study.

**Files to use** - Generate_Heatmaps.m 
**Dependecies** - Permutation_Heatmaps.m, permutationTest.m 

```
Generate_Heatmaps;
```

#### Normalised Curves

For qualitative purposes, it is useful to show grip aperture, velocity and acceleration profiles over the entire reaching to grasp movement. This can show at a glance any changes to the amplitude or the timings of the amplitude. This code normalises time by converting each prehensile movement into a percentage. Data points are interpolated onto 100 points (or extrapolated if there are <100 frames to use). 

**Files to use**  - PlotAverageCurves_shaded.m
**Dependecies** - shadedErrorBar.m, DataPrep_ErrorShade.m

```
timei = linspace(0,100);
for i = 1:height(MasterData)
  MasterData.mgainterp{i} = interp1(MasterData.Mgatrials{i}(:,1),MasterData.Mgatrials{i}(:,2),timei(:),'linear','extrap');
end

MGA_ECL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Left',:);
MGA_ECR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Control Right',:);
MGA_ELL = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Left',:);
MGA_ELR = MasterData.mgainterp(MasterData.ExpCohortHand == 'Efron Lesion Right',:);

MGA_ECL_mat = DataPrep_ErrorShade(MGA_ECL);
MGA_ECR_mat = DataPrep_ErrorShade(MGA_ECR);
MGA_ELL_mat = DataPrep_ErrorShade(MGA_ELL);
MGA_ELR_mat = DataPrep_ErrorShade(MGA_ELR);

figure;
shadedErrorBar(timei,mean(MGA_ECL_mat,1),std(MGA_ECL_mat)/sqrt(90),'lineprops','b');
hold on 
shadedErrorBar(timei,mean(MGA_ECR_mat,1),std(MGA_ECR_mat)/sqrt(78),'lineprops','r');
shadedErrorBar(timei,mean(MGA_ELL_mat,1),std(MGA_ELL_mat)/sqrt(86),'lineprops','g');
shadedErrorBar(timei,mean(MGA_ELR_mat,1),std(MGA_ELR_mat)/sqrt(86),'lineprops','k');
```
**add image of figure** 

#### Permutation Distributions 

While not used in the published version, I toyed with the idea of showing permutation distributions before settling on heatmaps instead. I kept this in here should you decide this is more fitting for your dataset/question. 

**Files to use** - Permutation_PlotData.m 
**Dependecies** - permutationTest.m
```
Parameter = MasterData.AverageMGA;
[AverageMGA_p,AverageMGA_eff] = Permutation_PlotData(MasterData,Parameter,AllPredictors);
```

#### Logistic Regression Model 

Here we modelled all the parameters and asked the question, which parameter(s) predict the likelihood of an animal being lesioned with the highest power? Due to the binary nature of either being lesioned or non-lesioned we opted for the logistic regression model to answer this question. 

```
Give examples
```

**Add demo data and images!!** 

## Authors

* [**Dylan Fox**](https://github.com/DylanFox)

## License

This program is licensed under GPL v3. See [LICENSE.txt](LICENSE.txt) file in the repository for details.

## Acknowledgments

* [permutationTest.m](https://github.com/lrkrol/permutationTest) - Laurens R Krol
* [shadedErrorBar.m](https://github.com/raacampbell/shadedErrorBar) - Rob Campbell

## Change Log 

10th December 2018

* Removed unused scripts, figures and .mat files 
* Added commentary to ImportData.m for greater accessibility
* Changed variable names across the board to be more intuitive 
* Removed redundant lines in PlotAverageCurves_shaded.m

11th December 2018 
* Removed unfiltered data from a previous project 
* Created scripts for generating permutation distributions of the dataset (could be condensed into a function but this is not a priority) 
* Modified line 123 of permutationTest.m to plot a red dashed line for the observed difference rather than a red asterisk
* Created Generate_Heatmaps script 
* Copied Permutation_PlotData.m into Heatmaps folder and renamed it to Permutation_Heatmap.m, removed the plotting feature to increase speed since only the heatmaps need to be plotted 
* Added example images for heatmaps, normalised curves and permutation distributions 

