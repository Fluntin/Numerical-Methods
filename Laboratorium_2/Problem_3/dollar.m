clc
close all
load('dollarkurs.mat')

% independent variable
t = 1:730; % per day

%  dependent variable
y = USDSEK;

%---------------Uppgift 1 a och b-----------------
% design matrix for the linear model

X = [ones(length(t), 1), t'];

coeff = (X' * X) \ (X' * y);

linear_approx = X * coeff;

error = y - linear_approx;

mse = mean(error.^2);
disp(['Medelkvadratfel för linjär funktion är: ', num2str(mse)]);

figure;

subplot(2, 2, 1);
plot(t, y, 'b.'); 
hold on;
plot(t, linear_approx, 'r-'); 
xlabel('Time (days)');
ylabel('Dollar exchange rate');
title('Dollar exchange rate and fitted linear model');
legend('Original data', 'Fitted curve');

% Plot the error in the second subplot
subplot(2, 2, 2);
plot(t, error, 'g-');
xlabel('Time (dagar)');
ylabel('Error');
title('Error between the linear model and the data');
legend('Error graph')

%----------Uppgift 1c--------------------------

% Define the dependent variable
y0 = USDSEK;
L = 460;

X0 = [ones(length(t), 1), t', sin(2 * pi * t' ./ L), cos(2 * pi * t' ./ L)];

c = (X0' * X0) \ (X0' * y0);

func_approx = X0 * c;
error2 = y0 - func_approx;
mse2 = mean(error2 .^ 2);
disp(['Medelkvadratfel för den trigonemtriska funktionen är: ', num2str(mse2)]);

subplot(2, 2, 3);
plot(t, y0, 'b.'); 
hold on;
plot(t, func_approx, 'r-');
xlabel('Time (dagar)');
ylabel('Dollarkurs');
title('Dollarkurs och anpassade funktion');
legend(' Dollarkurs och anpassade modelen')

subplot(2, 2, 4);
plot(t, error2, 'g-');
xlabel('Time (dagar)');
ylabel('Error');
title('Felet mellan data & den anpassade modellen');
legend('Error graph')

%----------------uppgift 1c--------------------

d_init = [c; L];

% Gauss-Newton's method
max_iter = 100; % max number of iterations
tol = 1e-6; % tolerance 

d = d_init;
for iter = 1:max_iter
    
    F = d(1) + d(2)*t' + d(3)*sin(2*pi*t'/d(5)) + d(4)*cos(2*pi*t'/d(5));
    r = y - F;


    
    J = [ones(size(t));...
        t;...
        sin(2*pi*t/d(5));...
        cos(2*pi*t/d(5));...
        (-2*pi*d(3)*t.*cos(2*pi*t/d(5)) + 2*pi*d(4)*t.*sin(2*pi*t/d(5)))./d(5).^2]';

    
    delta_d = (J'*J) \ (J'*r);
    d = d + delta_d;
    

    if norm(delta_d) < tol
        break;
    end
end


F_opt = d(1) + d(2)*t' + d(3)*sin(2*pi*t'/d(5)) + d(4)*cos(2*pi*t'/d(5));
% ... (previous code)

% Calculate the error for the Gauss-Newton method
error_gauss_newton = y - F_opt;
mse_gauss_newton = mean(error_gauss_newton .^ 2);
disp(['Medelkvadratfel för Gauss-Newton metoden är: ', num2str(mse_gauss_newton)]);

% Plot 
figure;
subplot(2, 2, 1);
plot(t, USDSEK, 'b.');
hold on;
plot(t, F_opt, 'r-');
xlabel('Time (days)');
ylabel('Dollar exchange rate');
title('Dollar exchange rate and fitted model using Gauss-Newton');
legend('Original data', 'Fitted curve');
ylim([6.5, 9.5]);

% Plot the error for the Gauss-Newton method in the second subplot
subplot(2, 2, 2);
plot(t, error_gauss_newton, 'g-');
xlabel('Time (days)');
ylabel('Error');
title('Error between the Gauss-Newton method and the data');
legend('Error graph');
