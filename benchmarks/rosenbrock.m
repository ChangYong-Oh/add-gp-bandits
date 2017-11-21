function [ output ] = rosenbrock( x )
%Rosenbrock not addtive valley
    assert(min(size(x)) == 1)
    normalizer = 50000.0 / ((90 ^ 2 + 9 ^ 2) * (max(size(x)) - 1));
    w = x * 7.5 + 2.5;
    output = sum(100.0 * (w(2:end) - w(1:end-1).^2).^2 + (w(1:end-1) - 1).^2) * normalizer;
end
