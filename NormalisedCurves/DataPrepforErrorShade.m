function [output_mat] = DataPrepforErrorShade(MGA_input)
output_mat = horzcat(MGA_input);
output_mat = cell2mat(output_mat);
output_mat = reshape(output_mat,100,[]);
output_mat = output_mat';
end 
