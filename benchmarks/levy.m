function [ output ] = levy( x )
%LEVY 1d-additive many local minima
    w = (10 * x - 1.0) / 4.0 + 1.0;
    output = sum((w(1:end-1) - 1).^2 .* (1 + 10 * sin(pi * w(1:end-1) + 1).^2));
    output = output + sin(pi * w(1))^2 + (w(end) - 1)^2 * (1 + sin(2 * pi * w(end))^2);
end

