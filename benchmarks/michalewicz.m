function [ output ] = michalewicz( x )
    w = (x + 1) * 0.5 * pi;
    m = 10;
    index = reshape((1:numel(x)), size(x));
    output = -mean(sin(w) .* sin(w.^2 .* index / pi).^(2 * m));
end