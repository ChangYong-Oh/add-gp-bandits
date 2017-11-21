function [ output_args ] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
    dirnames = strsplit(mfilename('fullpath'), '/');
    dirnames = dirnames(1:end-4)
end

