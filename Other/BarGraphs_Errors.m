%Code for making very nice bargraphs with errorbars in the right place 

%INPUT 'y' and 'y_error' and 'x_bins' 
%y is your data grouped in [1,2;3,4;5,6]
%y_error is the SD or w/e for that data
%x_bins is the labels you want to associate with each group of x

h = bar(y);
set(h,'BarWidth',1);    % The bars will now touch each other
set(gca,'YGrid','on')
set(gca,'GridLineStyle','-')
set(gca,'XTick',1:4,'XTickLabel',x_bins);
set(get(gca,'YLabel'),'String','U')
lh = legend('Serie1','Serie2','Serie3');
set(lh,'Location','BestOutside','Orientation','horizontal')
hold on;
numgroups = size(y, 1); 
numbars = size(y, 2); 
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
      % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
      x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
      errorbar(x, y(:,i), y_error(:,i), 'k', 'linestyle', 'none');
end 