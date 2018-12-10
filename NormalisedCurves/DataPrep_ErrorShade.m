function [output_mat] = DataPrepforErrorShade(parameter_input)
output_mat = horzcat(parameter_input);
output_mat = cell2mat(output_mat);
output_mat = reshape(output_mat,100,[]);
output_mat = output_mat';
end 
