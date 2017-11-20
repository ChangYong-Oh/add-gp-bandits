function [ output ] = rotatedstyblinskitang( x )
%ROTATEDSTYBLINSKITANG not additive d^2 local minima
    if size(x, 1) ~= 1
        x = x';
    end
    assert(size(x, 1) == 1)
    x = mtimes(x, generate_orthogonal_matrix(numel(x)));
    w = x * 5;
    output = (mean(w.^4) - 16 * mean(w.^2) + 5 * mean(w)) / 2.0;
end


function [ orthogonal_matrix ] = generate_orthogonal_matrix( ndim )
    x = exp(sin(linspace(-ndim^0.5, ndim^0.5, ndim)));
    x_repeated = repmat(x, ndim, 1);
    gram_mat = exp(-(x_repeated - x_repeated').^2);
    [orthogonal_matrix, ~] = qr(gram_mat);
end
