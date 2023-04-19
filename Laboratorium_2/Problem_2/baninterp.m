function [xn, xm, ym] = baninterp(h, typ)

[~, x, y, vx, vy] = kastbana(h);

% Linjär interpolation
if typ == 1

    % Hitta index där y värde plus(+) till minus(-)
    index = find(y(1:end-1).*y(2:end) < 0);

    lutning = (x(index+1) - x(index))/(y(index+1) - y(index));
    xn = x(index) + lutning*(0 - y(index));
    
    %----------------------------------------------------------------------
    % Linear högsta punkt

    % Index högsta punkt
    [~,index_max] = max(y);

    %lutning = (x(index_max+1)-x(index_max-1))/(y(index_max+1) - y(index_max-1));
    %xm = x(index_max-1) + lutning*(max(y) - y(index_max-1));
    xm=x(index_max);
    ym = y(index_max);

    % Print
    fprintf('x-koordinaten för nedslagsplatsen : ( %f)\n',xn);
    fprintf('Hogsta punkt: (%f, %f)\n', xm, ym);

    % Call kastbana.m to calculate the ball's trajectory
[t, x, y, vx, vy] = kastbana(h);

% Plot--------------------------------------------------------------------
plot(x, y, 'b-', 'LineWidth', 2);
hold on;

% Add a horizontal line at y=0
plot([min(x), max(x)], [0, 0], 'k--', 'LineWidth', 1);

% Add circles to mark timepoints at intervals of n*h
n = 50; % number of circles to add
t_circle = linspace(0, t(end), n+1);
x_circle = interp1(t, x, t_circle);
y_circle = interp1(t, y, t_circle);
plot(x_circle, y_circle, 'ro', 'MarkerSize', 4);

% Add axis labels and a title
xlabel('Horisontell position [m]');
ylabel('Vertikal position [m]');
title('Bollens bana');

% Adjust the axis limits to fit the trajectory
margin = 0.1; % fraction of margin to add
axis([min(x)-margin*range(x), max(x)+margin*range(x),min(y)-margin*range(y), max(y)+margin*range(y)]);
end
% ------------------------------------------------------------------------
% Kvadratisk interpolation - Low point
if typ == 2

    % Hitta index där y värde plus(+) till minus(-)
    index = find(y(1:end-1).*y(2:end) < 0);

    % Use the last three points to form a quadratic equation
    x1 = x(index-1); x2 = x(index); x3 = x(index+1);
    %fprintf('Hogsta punkt the 3 x coordinates: (%f, %f, %f)\n', x1, x2, x3);

    y1 = y(index-1); y2 = y(index); y3 = y(index+1);
    %fprintf('Low punkt the 3 y coordinates: (%f, %f, %f)\n', y1, y2, y3);
    A = [x1^2 x1 1; x2^2 x2 1; x3^2 x3 1];
    b = [y1; y2; y3];
    coeff = A\b;
    % Use the quadratic equation to find the x-coordinate of the landing point
    xn = (-coeff(2) - sqrt(coeff(2)^2 - 4*coeff(1)*(coeff(3) - 0)))/(2*coeff(1));

    %----------------------------------------------------------------------
    % Kvadratisk interpolation - Highest point
    
    % Index of the highest point
    [~, index_max] = max(y);
    
    % Use the last three points to form a quadratic equation
    x1 = x(index_max-1); x2 = x(index_max); x3 = x(index_max+1);
    %fprintf('Hogsta punkt the 3 x coordinates: (%f, %f, %f)\n', x1, x2, x3);
    
    y1 = y(index_max-1); y2 = y(index_max); y3 = y(index_max+1);
    %fprintf('Hogsta punkt the 3 y coordinates: (%f, %f, %f)\n', y1, y2, y3);

    Am = [x1^2 x1 1; x2^2 x2 1; x3^2 x3 1];
    bm = [y1; y2; y3];
    coeffm = Am\bm;
    xm = -coeffm(2) / (2 * coeffm(1));
    %xm = (-coeffm(2) - sqrt(coeffm(2)^2 - 4*coeffm(1)*(coeffm(3) - 0)))/(2*coeffm(1));
    %ym = coeff(1)*index_max^2 + coeff(2)*index_max + coeff(3);
    ym = y(index_max);


    % Print
    fprintf('x-koordinaten för nedslagsplatsen : ( %f)\n',xn);
    fprintf('Hogsta punkt: (%f, %f)\n', xm, ym);
% Plot--------------------------------------------------------------------
% Ange steglängden för kastbana.m
h = 0.0001;

% Call kastbana.m to calculate the ball's trajectory
[t, x, y, vx, vy] = kastbana(h);

% Plot
plot(x, y, 'b-', 'LineWidth', 2);
hold on;

% Add a horizontal line at y=0
plot([min(x), max(x)], [0, 0], 'k--', 'LineWidth', 1);

% Add circles to mark timepoints at intervals of n*h
n = 50; % number of circles to add
t_circle = linspace(0, t(end), n+1);
x_circle = interp1(t, x, t_circle);
y_circle = interp1(t, y, t_circle);
plot(x_circle, y_circle, 'ro', 'MarkerSize', 4);

% Add axis labels and a title
xlabel('Horisontell position [m]');
ylabel('Vertikal position [m]');
title('Bollens bana');

% Adjust the axis limits to fit the trajectory
margin = 0.1; % fraction of margin to add
axis([min(x)-margin*range(x), max(x)+margin*range(x),min(y)-margin*range(y), max(y)+margin*range(y)]);
% ------------------------------------------------------------------------
end








