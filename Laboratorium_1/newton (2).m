function [xroot] = newton(x_0, tau)
    MaxIterations = 25; % Max iteration
    x_1=10000;
    err=abs(x_1-x_0);
    iterations = 0; % Räknar antalet iterationer 
    f = @(x) x^2-8*x-5*sin(3*x+1)+12; % Vår funktion
    deriv = @(x) -15*cos(3*x+1)+2*x-8; % Derivatan av vår funktion
    x_1 = x_0-feval(f,x_0)/feval(deriv,x_0); % Newtons metod
    diff = []; % En tom lista som sparar absolut värdet av differansen mellan varje iteration 
    while ((err>tau) && iterations <= MaxIterations) % While loop som kollar om det nuvarande iteration inte överskrider det tillåtna
        x_0 = x_1; % updaterar x_0
        x_1 = x_0-feval(f,x_0)/feval(deriv,x_0); % Uppdaterar x_1
        err=abs(x_1-x_0);
        diff = [diff, abs(x_1-x_0)]; % lägger till absolut värdet av differansen.
        iterations = iterations+1; % Inkrementar variabeln iteration med 1 varje gång
        fprintf('x_n: %f, diff: %f\n', x_1, err); % Skriver ut varje x_n och error
        if err < tau % Kollar om error är mindre än tau, i sådana fall skriver den ut rooten.
            fprintf('x: Final root is  %d',x_1)
            break;
        end
    end
    semilogy(1:iterations, diff, 'o-'); % Plottar figuren i logaritmisk skala. 
    xroot = x_1; %Funktionen newton return värde sparas i variabeln xroot.
end

% Kod för konvplot1.png newtons metod uppgift 1.c
