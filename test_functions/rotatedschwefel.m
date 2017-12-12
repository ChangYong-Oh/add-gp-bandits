function [ output ] = rotatedschwefel( x )
    if size(x, 1) ~= 1
        x = x';
    end
    assert(size(x, 1) == 1)
    x = mtimes(x, generate_orthogonal_matrix(numel(x)));
    w = x * 500.0;
    output = 418.9829 - mean(w.*sin(abs(w).^0.5));
end


function [ orthogonal_matrix ] = generate_orthogonal_matrix( ndim )
    x = exp(sin(linspace(-ndim^0.5, ndim^0.5, ndim)));
    x_repeated = repmat(x, ndim, 1);
    gram_mat = exp(-(x_repeated - x_repeated').^2);
    [orthogonal_matrix, ~] = qr(gram_mat);
end
