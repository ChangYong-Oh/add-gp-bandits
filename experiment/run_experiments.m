% func_name, numDims, numIters, maxGroupSize, decompStrategy
% 'partialLearn', 'stoch1'

addpath ./addGPLibkky/
addpath ./BOLibkky/
addpath ./utils/
addpath ./benchmarks/
    

func_name_cell = ...
    {'levy', 'michalewicz', 'rosenbrock', 'rotatedschwefel',...
     'rotatedstyblinskitang', 'schwefel', 'styblinskitang'};
numDims = [20, 50, 100, 200, 1000];
numIters = [200, 400, 600, 800, 1000];
maxGroupSize = [];
maxGroupSize(1, :) = [ 3,  5, 10, 13, 18];
maxGroupSize(2, :) = [ 5, 10, 13, 25, 45];
maxGroupSize(3, :) = [ 5, 10, 25, 32, 50];
maxGroupSize(4, :) = [10, 15, 25, 40, 50];
maxGroupSize(5, :) = [10, 25, 50, 60, 90];
decompStrategy = {'partialLearn', 'stoch1'};

for s = 1:2
    for d = 1:5
        for f = 1:numel(func_name_cell)
            for g = 1:5
                run_additive_BO(func_name_cell(f), numDims(d), numIters(d), maxGroupSize(d, g), decompStrategy(s));
            end
        end
    end
end