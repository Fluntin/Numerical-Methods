
clc
close all
format long
% Parametrar
tol = 1e-6;
max_iter = 100;
h = 1e-6;


%---------------Uppgift 3 det inversa problemet med gauss newton-----

% Startgissning
k_guess = ones(5,1);

S0 = [ 1.10 -0.19 -0.37 -0.55;
      -0.18  1.11 -0.15 -0.77;
      -0.38 -0.16  0.95 -0.40;
      -0.57 -0.80 -0.42  1.75];

% Gauss-Newton iteratio
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
felkvadrat_sum = sum(F_vector(k_solution, S0).^2);

% Calculate the resistances
r_solution = 1 ./ k_solution;

fprintf('Lösning på uppgift 3 \n')
disp(['Lösning (konduktanserna) är: ' num2str(k_solution')])
disp(['Resistanserna är: ' num2str(r_solution')])
disp(['Felkvadratsumma: ' num2str(felkvadrat_sum)])
disp(['Antal iterationer: ' num2str(iter)])
fprintf('-----------------')

%----------SLut på uppgift 3---------------------


%------------------Störningsberäkning--------------------
fprintf('Lösning 3 del 2 \n')
resistanser=storningsrakning();
fprintf('---------------------------------')


%---------------Optimering---------------------------------
fprintf('----Lösning på uppgift 4-----\n')
golden_search();
fprintf('---------------------------------')

%----------Slut på fråga 4--------------

