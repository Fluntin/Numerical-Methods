clc
close all

% Parametrar
tol = 1e-6;
max_iter = 100;
h = 1e-6;

% Startgissning
k_guess = ones(5,1);

S0 = [ 1.10 -0.19 -0.37 -0.55;
      -0.18  1.11 -0.15 -0.77;
      -0.38 -0.16  0.95 -0.40;
      -0.57 -0.80 -0.42  1.75];

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

k_solution = k_guess;
felkvadrat_sum = sum(F_vector(k_solution, S0).^2) / 16;

% Calculate the resistances
r_solution = 1 ./ k_solution;
%------------------Störningsberäkning--------------------
% Teori? [y-y']/y≈A*A^-1 *[x-x']/x
% S0 har felgräns 2%, räkna ut först k_solution sedan stör med felgräns,
% [x_exp-x] ≈ approximation till felgräns

disp(['Solution (conductances) is: ' num2str(k_solution')])
disp(['Resistancerna är: ' num2str(r_solution')])
disp(['Felkvadratsumma: ' num2str(felkvadrat_sum)])
disp(['Antal iterationer: ' num2str(iter)])
