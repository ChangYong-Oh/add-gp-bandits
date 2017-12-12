function [ output ] = branin( x )
    a = 1;
	b = 5.1 / (4 * pi ^ 2);
	c = 5.0 / pi;
	r = 6;
	s = 10;
	t = 1.0 / (8 * pi);

    n_repeat = floor(numel(x) / 2);
    shift = zeros(size(x));
    shift((1:n_repeat) * 2 - 1) = 2.5;
    shift((1:n_repeat) * 2) = 7.5;
    w = x * 7.5 + shift;
    output = 0;
    for i = 1:n_repeat
        output = output + a*(w(2*i) - b*w(2*i-1)^2 + c*w(2*i-1) - r)^2 + s*(1-t)*cos(w(2*i-1)) + s;
    end
    output = output / n_repeat;
end

