function golden_search()

% Definiera B0 och B1
B0 = [1.0, -0.3, -0.3, -0.4;       -0.3, 1.0, 0.0, -0.7;       -0.3, 0.0, 0.9, -0.6;       -0.4, -0.7, -0.6, 1.7] * 1e-3;
B1 = [0.3, 0.3, -0.2, -0.4;       0.3, 0.3, -0.4, -0.2;       -0.2, -0.4, 0.1, 0.5;       -0.4, -0.2, 0.5, 0.1] * 1e-3;

% Definiera funktionen som beräknar resistanserna givet eta
f = @(eta) perturbation(B0 + eta * B1);

% Definiera kostnadsfunktionen
P = @(r) 1 + 10 * (r / 1000).^2;

%P=pris(eta)

% Definiera totala kostnadsfunktionen givet eta
Ptot = @(eta) sum(P(f(eta  )));

% Definiera toleransen och max antal iterationer för gyllene snittet-sökning
tol = 1e-6;
max_iter = 100;


% Gyllene snittet-sökning
tau = (sqrt(5) - 1) / 2; % Gyllene snittet

a = 0;
b = 1;
x = a + (1-tau)*(b-a);
y = a + tau*(b-a);

fa=sum(P(f(a)));
fb=sum(P(f(b)));
fx=sum(P(f(x)));
fy=sum(P(f(y)));


iter = 0;
while abs(b - a) > tol && iter < max_iter
    %x = a + (1-tau)*(b-a);
    %y = b - tau*(b-a);
    if (fx > fy)
        a = x; fa=fx;
        x=y; fx=fy;
        y = a + (b-a)*tau; fy=sum(P(f(y)));

    else
       b=y; fb=fy;
       y=x; fy=fx;
       x=a+(b-a)*(1-tau); fx=sum(P(f(x)));
    end
    iter = iter + 1;
    
end

% Hitta optimala eta och resistanser
eta_opt = (a + b) / 2;
r_opt = f(eta_opt);
Ptot_opt = Ptot(eta_opt);

% Beräkna felkvadratsumman för eta_opt
S_opt = B0 + eta_opt * B1;
F_opt = F_vector(r_opt, S_opt);
felkvadratsum_opt = sum(F_opt);

% Skriv ut resultatet
fprintf('Optimala eta: %f\n', eta_opt);
fprintf('Resistanser: [%f, %f, %f, %f, %f]\n', r_opt);
fprintf('Total kostnad: %f\n', Ptot_opt);
fprintf('Felkvadratsumma för optimala eta: %e\n', felkvadratsum_opt);
fprintf('Antal iterationer i gyllene snittet-sökning: %d\n', iter);
fprintf('Tolerans för gyllene snittet-sökning: %e\n', tol);
end