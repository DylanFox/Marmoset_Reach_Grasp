function [y] = PlotAverageCurve_MGA(x)
%----Generate average curve----% 

% To average the curves, you have to average them at the SAME x-values
%First set up an appropriate vector for X, I've chosen 100 points 
timei = linspace(0,100);

%Interpolate or Extrapolate Y data points to the length of X vector
for i = 1:height(x) 
    x.mgainterp{i} = interp1(x.Mgatrials{i}(:,1),x.Mgatrials{i}(:,2),timei(:),'linear','extrap');  
end 
y_mean = mean([x.mgainterp{:}],2);

%Plot SEM into the average curve 
y_std = std([x.mgainterp{:}],1,2);
y_SEM = y_std/sqrt(height(x));
figure; y = errorbar(timei,y_mean,y_SEM)

