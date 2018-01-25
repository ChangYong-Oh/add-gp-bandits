function run_additive_BO(func_name, numDims, numIters, maxGroupSize, decompStrategy)
    % Experiment Set up for Bayesian Optimization and GP Bandits

    rng('shuffle');

    assert(strcmp(decompStrategy, 'partialLearn') | strcmp(decompStrategy, 'stoch1'))
    assert(numDims >= maxGroupSize)
    
    dirnames = strsplit(mfilename('fullpath'), '/');
    dirnames = dirnames(1:end-4);
    dirnames{end + 1} = 'Experiments/Additive_BO_mat/';
    exp_result_dir = strjoin(dirnames, '/');
    time_tag = datestr(now(), 'yyyymmdd-HH:MM:SS:fff');
    
    numExperiments = 5;

    % Different configuration for different experiments
    if strcmp(func_name, 'levy')
        func = @(t) -levy(t);
    elseif strcmp(func_name, 'michalewicz')
        func = @(t) -michalewicz(t);
    elseif strcmp(func_name, 'rosenbrock')
        func = @(t) -rosenbrock(t);
    elseif strcmp(func_name, 'rotatedschwefel')
        func = @(t) -rotatedschwefel(t);
    elseif strcmp(func_name, 'rotatedstyblinskitang')
        func = @(t) -rotatedstyblinskitang(t);
    elseif strcmp(func_name, 'schwefel')
        func = @(t) -schwefel(t);
    elseif strcmp(func_name, 'styblinskitang')
        func = @(t) -styblinskitang(t);
    end

    filename_prefix = strcat(func_name, '_D', int2str(numDims), '_maxGS', int2str(maxGroupSize) , '_', decompStrategy);

    bounds = [-ones(numDims, 1), ones(numDims, 1)];

    initPoints = [zeros(1, numDims); unifrnd(-1, 1, 1, numDims)];
    n_init_points = size(initPoints, 1); 

    queries = zeros(0, numIters + n_init_points, numDims);
    neg_values = zeros(0, numIters + n_init_points, 1);
    neg_optima = zeros(0, numIters + n_init_points, 1);

    % Call adGPBO
    for i=1:numExperiments
        d = maxGroupSize; % Add-GP-UCB with maximum group size d;
        params = struct();
        params.decompStrategy = decompStrategy;
        
        [decomp, boAddParams] = ...
        preprocessDecomposition(numDims, d, params, true);
    
        boAddParams.initPts = initPoints;
        boAddParams.initVals = [func(initPoints(1, 1:end)); func(initPoints(2, 1:end))];
        
        [maxVal, maxPt, boQueries, boVals, history] = ...
            addGPBO(func, decomp, bounds, numIters, boAddParams);
        queries(i, :, :) = boQueries;
        % Changing to minimization problem
        neg_values(i, :, :) = -boVals;
        neg_optima(i, :, :) = -history;
    end

    % Obtain the simple and cumulative regrets and plot them.
    save(strcat(exp_result_dir, filename_prefix , '_', time_tag, '_x.mat'), 'queries');
    save(strcat(exp_result_dir, filename_prefix , '_', time_tag, '_y.mat'), 'neg_values');
    save(strcat(exp_result_dir, filename_prefix , '_', time_tag, '_optimum.mat'), 'neg_optima');
end
