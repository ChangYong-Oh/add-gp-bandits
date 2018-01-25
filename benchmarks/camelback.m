function [ output ] = camelback( x )
    n_repeat = floor(numel(x) / 2);
    scale = zeros(size(x));
    scale((1:n_repeat) * 2 - 1) = 3.0;
    scale((1:n_repeat) * 2) = 2.0;
    w = x .* scale;
    output = 0;
    for i = 1:n_repeat
        output = output + (4.0 - 2.1*w(2*i-1)^2 + w(2*i-1)^4/3)*w(2*i-1)^2 + w(2*i-1)*w(2*i) + 4*(w(2*i)^2-1)*w(2*i)^2;
    end
    output = output / n_repeat;
end

