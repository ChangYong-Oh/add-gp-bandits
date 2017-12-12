function [ output ] = mnist_weight( x )
% x is vector, it should be reshaped
% this function calls python function
% python row-wise, matlab column-wise order
    tmpfilename = strcat('/tmp/matlab_mnist_weight_', datestr(now(), 'yyyymmdd-HH:MM:SS:FFF'), '.mat');
    save(tmpfilename, 'x');
    
    cmd_str_cell = strcat({'python '}, {mfilename('fullpath')}, {'.py'}, {' '}, {tmpfilename});
    [~, cmdout] = system(cmd_str_cell{1},'-echo');
    cmdlines = strsplit(cmdout, '\n');
    if strcmp(cmdlines{end}, '')
        output = str2double(cmdlines{end-1});
    else
        output = str2double(cmdlines{end});
    end
end

