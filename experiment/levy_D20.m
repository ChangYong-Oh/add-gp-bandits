% Experiment Set up for Bayesian Optimization and GP Bandits

close all;
clear all;
addpath ../addGPLibkky/
addpath ../BOLibkky/
addpath ../utils/
addpath ../benchmarks/
warning off;
rng('shuffle');

exp_result_dir = '/home/coh1/Experiments/Additive_BO_mat/';

numExperiments = 5;

% Different configuration for different experiments
numIters = 200;
func = @(t) -levy(t);
func_name = 'levy';
numDims = 20;

filename_prefix = strcat(func_name, '_D', int2str(numDims));

bounds = [-ones(numDims, 1), ones(numDims, 1)];

d = 1; % Add-GP-UCB with maximum group size d = 4;

% Call additive GP Bandits
% ------------------------
% First call the following function to set up the hyper parameters
[decomp, boAddParams] = ...
  preprocessDecomposition(numDims, d, struct(), true);
initPoints = [zeros(1, numDims); ones(1, numDims)];
n_init_points = size(initPoints, 1);
boAddParams.initPts = initPoints;
boAddParams.initVals = [func(initPoints(1, 1:end)); func(initPoints(2, 1:end))];

queries = zeros(0, numIters + n_init_points, numDims);
neg_values = zeros(0, numIters + n_init_points, 1);
neg_optima = zeros(0, numIters + n_init_points, 1);

% Call adGPBO
for i=1:numExperiments
    [maxVal, maxPt, boQueries, boVals, history] = ...
        addGPBO(func, decomp, bounds, numIters, boAddParams);
    queries(i, :, :) = boQueries;
    % Changing to minimization problem
    neg_values(i, :, :) = -boVals;
    neg_optima(i, :, :) = -history;
end

% Obtain the simple and cumulative regrets and plot them.
save(strcat(exp_result_dir, filename_prefix, '_x.mat'), 'queries');
save(strcat(exp_result_dir, filename_prefix, '_y.mat'), 'neg_values');
save(strcat(exp_result_dir, filename_prefix, '_optimum.mat'), 'neg_optima');

