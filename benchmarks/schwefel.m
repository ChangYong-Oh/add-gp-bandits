function [ output ] = schwefel( x )
%SCHWEFEL 1d-additive many local minima
    w = x * 500.0;
    output = 418.9829 - mean(w .* sin(abs(w).^0.5));
end

