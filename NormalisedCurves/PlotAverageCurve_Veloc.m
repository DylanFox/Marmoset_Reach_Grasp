function [] = PlotAverageCurveVeloc(x)
%----Generate average curve----% 

% To average the curves, you have to average them at the SAME x-values
%First set up an appropriate vector for X, I've chosen 100 points 
timei = linspace(0,100);

%Interpolate or Extrapolate Y data points to the length of X vector
for i = 1:height(x) 
    x.velocinterp{i} = interp1(x.thumbvelocity{i}(2:end-1,1),x.thumbvelocity{i}(2:end-1,2),timei(:),'linear','extrap');
end 
y_mean = mean([x.velocinterp{:}],2);

%Plot SEM into the average curve 
y_std = std([x.velocinterp{:}],1,2);
y_SEM = y_std/sqrt(height(x));
errorbar(timei,y_mean,y_SEM)

