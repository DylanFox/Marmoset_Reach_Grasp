function y=nansem(x)
%Finds SEM while excluding any instances of NaNs
nonanx=x(~isnan(x));
y=std(nonanx) / sqrt(size(nonanx,2));
end




