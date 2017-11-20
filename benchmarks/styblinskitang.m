function [ output ] = styblinskitang( x )
%STYBLINSKITANG 1d-additive d^2 local minima
    w = x * 5;
    output = (mean(w.^4) - 16 * mean(w.^2) + 5 * mean(w)) / 2.0;    
end

