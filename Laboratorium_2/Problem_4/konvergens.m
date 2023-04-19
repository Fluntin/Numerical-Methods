
%b1
% Beräkna referenslösning med mycket hög precision
R = 3;
g_handle = @(r) g(r).*r;
%g_handle = @(r) g(r);


% 6 Eller med Matlabs inbyggda funktion integral. Default-noggrannheten 
% i integral är dock för låg i detta fall, och måste i så fall ökas.
%This will be used as reference for calculating the error.
%V_tilde = (g(R) * R^2 * pi) - 2 * pi * integral(g_handle, 0, R, 'RelTol', 1e-12, 'AbsTol', 1e-12)
V_tilde = (g(R) * R^2 * pi) - 2 * pi * integral(g_handle, 0, R, 'RelTol', 1e-1000, 'AbsTol', 1e-1000);


% Beräkna felet för olika steglängder h
% Row vector n_values containing a sequence of even integer values 
% start at 2 and +2 up to 100.

n_values = 2:2:100; % Jämnt antal delintervall för Simpson
h_values = R ./ n_values;

%Vector or array of all zeros with the same size.
E_trapets = zeros(size(h_values));
E_simpson = zeros(size(h_values));

for i = 1:length(n_values)
    n = n_values(i);
    V_trapets = trapets(n);
    V_simpson = simpson(n);
    
    E_trapets(i) = abs(V_tilde - V_trapets);
    E_simpson(i) = abs(V_tilde - V_simpson);
end

% Plotta felet som funktion av steglängd h
figure;
loglog(h_values, E_trapets, '-o', h_values, E_simpson, '-x');
xlabel('Steglängd h');
ylabel('Approximationsfel E_h');
title('Approximationsfel för Trapetsregeln och Simpsons metod');
grid on;

% % Add line with slope 2 and label h^2
% hold on;
% loglog(h_values, 2*h_values.^2, '--', 'Color', [0.5, 0.5, 0.5], 'DisplayName', 'h^2');
% 
% % Add line with slope 4 and label h^4
% loglog(h_values, 150*h_values.^4, ':', 'Color', [0.5, 0.5, 0.5], 'DisplayName', 'h^4');
% 
% legend('Trapetsregeln', 'Simpsons metod', 'h^2', 'h^4', 'Location', 'northwest');
% Add line with slope 2 and label h^2
hold on;
k1 = 10; % Adjust this constant to match your data
loglog(h_values, k1*h_values.^2, '--', 'Color', [0.5, 0.5, 0.5], 'DisplayName', 'h^2');

% Add line with slope 4 and label h^4
k2 = 10; % Adjust this constant to match your data
loglog(h_values, k2*h_values.^4, ':', 'Color', [0.5, 0.5, 0.5], 'DisplayName', 'h^4');

legend('Trapetsregeln', 'Simpsons metod', 'h^2', 'h^4', 'Location', 'northwest');





%b2
%Same trick as the b) 1
n_values = 2:2:60; % Jämnt antal delintervall för Simpson
h_values = R ./ n_values;

ratio_trapets = zeros(size(h_values));
ratio_simpson = zeros(size(h_values));

for i = 3:length(n_values)
    n = n_values(i);
    
    V_trapets_h = trapets(n);
    V_trapets_h_half = trapets(2 * n);
    V_trapets_h_quarter = trapets(4 * n);
    
    V_simpson_h = simpson(n);
    V_simpson_h_half = simpson(2 * n);
    V_simpson_h_quarter = simpson(4 * n);
    
    ratio_trapets(i) = (V_trapets_h - V_trapets_h_half) / (V_trapets_h_half - V_trapets_h_quarter);
    ratio_simpson(i) = (V_simpson_h - V_simpson_h_half) / (V_simpson_h_half - V_simpson_h_quarter);
end

% Sammanställ tabell
T = table(n_values(3:end)', h_values(3:end)', ratio_trapets(3:end)', ratio_simpson(3:end')', ...
    'VariableNames', {'n', 'h', 'Trapets_kvot', 'Simpsons_kvot'});
disp(T);

n_values = 2:2:50;
h_values = (3 * sqrt(2)) ./ n_values;
ratio_trapets2d = zeros(size(h_values));

for i = 3:length(n_values)
    n = n_values(i);
    
    V_trapets2d_h = trapets2d(n);
    V_trapets2d_h_half = trapets2d(2 * n);
    V_trapets2d_h_quarter = trapets2d(4 * n);
    
    ratio_trapets2d(i) = (V_trapets2d_h - V_trapets2d_h_half) / (V_trapets2d_h_half - V_trapets2d_h_quarter);
end

% Sammanställ tabell
T2 = table(n_values(3:end)', h_values(3:end)', ratio_trapets2d(3:end')', ...
    'VariableNames', {'n', 'h', 'Trapets2D_kvot'});
disp(T2);

% Funktionen g(r)
function res = g(r)
    res = (3 .* r.^3 .* exp(-r)) ./ (1 + (1/3) .* sin((8 .* r) ./ 5));
end

%Noggrannhetsordningen för Simpsons metod är 4, vilket innebär att felet i 
% approximationen minskar som h^4, där h är steglängden. Det betyder att 
% om du minskar steglängden med hälften (h = h/2), så minskar felet med 
% en faktor på (1/2)^4 = 1/16. Detta gör Simpsons metod betydligt mer 
% exakt än trapetsmetoden, som har en noggrannhetsordning på 2.
