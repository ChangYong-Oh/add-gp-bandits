function [ output ] = bird( x )
    w = x * 2 * pi;
    n_repeat = floor(numel(x) / 2);
    output = 0;
    for i = 1:n_repeat
        output = output + (w(2*i-1)-w(2*i))^2 + exp((1-sin(w(2*i-1)))^2) * cos(w(2*i)) + exp((1-cos(w(2*i)))^2) * sin(w(2*i-1));
    end
    output = output / n_repeat;
end

