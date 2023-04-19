function [eigen, iter] = invpot(shift)
    load('eiffel1.mat')
    
    % Shift the matrix using the provided shift value
    A_shifted = A - shift * eye(size(A));
    
    v_0 = randn(size(A, 1), 1);
    iterations = 0;
    tolerance = 1e-10;
    lambda_0 = 0;
    lambda = 30;
    
    while abs(lambda_0 - lambda) > tolerance
        iterations = iterations + 1;
        lambda_0 = lambda;
        
        % Use the shifted matrix A_shifted in the computation
        v = A_shifted \ v_0;
        v = v / norm(v);
        lambda = (v' * v) + shift;
        v_0 = v;
        fprintf('Eigenvalue: %f, Iterations: %d\n', lambda, iterations)
    end
    
    fprintf('\nFinal solution: %f\n', lambda)
    
    % Compute the actual eigenvalue by taking the reciprocal and adding the shift back
    eigen = lambda;
    iter = iterations;
end
