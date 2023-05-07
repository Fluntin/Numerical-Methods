function J = Jacobian_numerical(k, S0, h)
  n = length(k);
  J = zeros(16, n);
  F0 = F_vector(k, S0);
  for i = 1:n
    k_plus_h = k;
    k_plus_h(i) = k_plus_h(i) + h;
    F_plus_h = F_vector(k_plus_h, S0);
    J(:, i) = (F_plus_h - F0) / h;
  end
end
