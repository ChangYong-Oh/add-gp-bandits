% func_name, numDims, numIters, maxGroupSize, decompStrategy
% 'partialLearn', 'stoch1'

addpath ./addGPLibkky/
addpath ./BOLibkky/
addpath ./utils/
addpath ./benchmarks/

func_name_cell = {'branin', 'hartmann6', 'rosenbrock', 'levy'};
% func_name_cell = ...
%     {'levy', 'michalewicz', 'rosenbrock', 'rotatedschwefel',...
%      'rotatedstyblinskitang', 'schwefel', 'styblinskitang'};
numDims = [20, 50, 100];
numIters = [200, 400, 600];
maxGroupSize = [];
maxGroupSize(1, :) = [ 3,  5, 10, 13, 18];
maxGroupSize(2, :) = [ 5, 10, 13, 25, 45];
maxGroupSize(3, :) = [ 5, 10, 25, 32, 50];
decompStrategy = {'partialLearn'};

for s = 1:numel(decompStrategy)
    for d = 1:numel(numDims)
        for f = 1:numel(func_name_cell)
            for g = 1:numel(maxGroupSize(d, :))
                run_additive_BO(func_name_cell{f}, numDims(d), numIters(d), maxGroupSize(d, g), decompStrategy{s});
            end
        end
    end
end