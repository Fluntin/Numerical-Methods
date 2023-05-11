function J = Jacobian_numerical(k, S0, h)
  n = length(k);               % Get the length of the vector k
  J = zeros(16, n);            % Initialize a 16xN zero matrix J
  F0 = F_vector(k, S0);        % Compute the function F_vector for the input k and S0

  % Iterate over each element in the vector k
  for i = 1:n
    k_plus_h = k;                  % Create a copy of k as k_plus_h
    k_plus_h(i) = k_plus_h(i) + h;  % Increment the i-th element of k_plus_h by h
    F_plus_h = F_vector(k_plus_h, S0);  % Compute the function F_vector for the input k_plus_h and S0

    % Compute the i-th column of the Jacobian matrix J using finite difference method
    J(:, i) = (F_plus_h - F0) / h;
  end
end
