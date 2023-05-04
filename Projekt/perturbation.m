function [solution]=perturbation(S0)


tol = 1e-6;
max_iter = 100;
h = 1e-6;

% Startgissning
k_guess = ones(5,1);



% Gauss-Newton iteration
iter = 0;
while iter < max_iter
  Fk = F_vector(k_guess, S0);
  Jk = Jacobian_numerical(k_guess, S0, h);
  delta_k = -Jk \ Fk;
  k_guess = k_guess + delta_k;
  
  if norm(delta_k) < tol
    break;
  end
  
  iter = iter + 1;
end

solution = 1./k_guess;


end
