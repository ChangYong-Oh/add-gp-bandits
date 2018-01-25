function [ output ] = qing( x )
    w = x * 500;
    output = 0;
    for i = 1:numel(x)
        output = output + (w(i)^2 - i)^2;
    end
    output = output / numel(x);
end

