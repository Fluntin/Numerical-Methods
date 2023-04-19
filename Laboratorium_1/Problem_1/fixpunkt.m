
%Kod för konvplot1.png fixpunktsmetoden uppgift 1.b uppdaterade den lite, men din funkar även bra.
function x_root = fixedIteration(x_0, tau)
    MaxIterations = 25; %Tillåtna antalet iterationer 
    currentIterations = 0; % Nuvarande iteration
    x_1 = ((x_0)^2)/12 + x_0/3 - 5*sin(3*x_0 + 1)/12 + 1; %Fix punkts metoden
    err = abs(x_1 - x_0); %Skillnaden mellan två iterationer
    
    figure;
    semilogy(currentIterations, err, 'o', 'Color', 'b'); %En punkt skapas med erhållna x_1 och x_0
    hold on; 
    while ((abs(x_1 - x_0) > tau) && (currentIterations <= MaxIterations)) %While loop som kollar att kraven är uppfyllda
        x_0 = x_1; %Uppdaterar x_0 till x_1
        x_1 = ((x_0)^2)/12 + x_0/3 - 5*sin(3*x_0 + 1)/12 + 1; %Uppdaterar x_1
        currentIterations = currentIterations + 1; %Inkrementerar x_1
        err = abs(x_1 - x_0); %Uppdaterar err variabeln
        semilogy(currentIterations, err, 'o', 'Color', 'b'); % % Printar vår figur som en funktion av antalet iterationer --> semilogy(Y,X)
        fprintf('x_n: %f, |x_n_+_1-x_n| : %f\n', x_1, abs(x_1-x_0)); %Printar varje x_n och varje error
    end
    xlabel('Iteration');
    ylabel('Error');
    title('Convergence difference between NewtonM vs FixedIteration');
    legend('Fixed point');
    if abs(x_1 - x_0) <= tau %Kollar om skillnaden mellan två iterationer är mindre än tau
        fprintf('Final root x is: %f\n', x_1); % om så printar den vår root.
        x_root = x_1; %Funktionen fixedIterations return värde sparas i x_root
    else % Om den inte konvergerar 
        x_root = NaN; % x_root sätts som None
        fprintf('Method failed to converge within %d iterations.\n', MaxIterations); % Printar att metoden inte konvergerar med det tillåtna antalet iterationer
    end
end

% För att få figuren som visar konvergens ordningen för varje metod, kör
% denna kod med egna val av tau och x_0 

%figure;
%fixediteration(x_0, tau);
%hold on;
%newton(x_0, tau);
