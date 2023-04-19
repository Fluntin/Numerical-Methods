function mcinteg(N)

%Uspper limit 
L = 1.2;
num_realizations = 5;

results = zeros(N, num_realizations);
errors = zeros(N, num_realizations);

ref=6.231467927023725;

for r = 1:num_realizations
    % Generate an N x 10 matrix of random numbers uniformly distributed between 0 and L:
    random_numbers = L * rand(N, 10);

    %Compute the function values for each row of random numbers:
    f_values = exp(prod(random_numbers, 2));

    % Calculate the integral approximations I_values for each number of 
    % function evaluations using the cumulative sum (cumsum(f_values)), 
    % scaling by (L^10), and dividing by the number of function evaluations (1:N)'.
    I_values = cumsum(f_values) .* (L^10) ./ (1:N)';
    %I_values = cumsum(f_values) .* (L^10) ./ (N)';


    results(:, r) = I_values;

    %Should we use trapets10d.m here???
    %errors(:, r) = abs(I_values - I_values(end));
    errors(:, r) = abs(I_values - ref);
end

figure;
plot(1:N, results);
xlabel('Number of function evaluations');
ylabel('Integral approximations');
title('Integral approximations for different realizations');
zoom on;

figure;
loglog(1:N, errors);
xlabel('Number of function evaluations');
ylabel('Error');
title('Error for different realizations');
hold on;
plot(1:N, 1./sqrt(1:N), 'r--'); % Add a red dashed line for 1/sqrt(N)
legend('Approximations', '1/sqrt(N)', 'Location', 'NorthWest');
zoom on;
end
