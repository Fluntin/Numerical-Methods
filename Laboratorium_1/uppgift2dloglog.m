function [xroot] = newtond2(x_0, tau)
    MaxIterations = 25; % Max iteration
    x_1=1;
    err=abs(x_1-x_0);
    iterations = 0; % Count the number of iterations
    f = @(x) x^2-8*x-5*sin(3*x+1)+12; % Our function
    deriv = @(x) -15*cos(3*x+1)+2*x-8; % Derivative of our function
    x_1 = x_0-feval(f,x_0)/feval(deriv,x_0); % Newton's method
    e_n = []; % A list to store the error at each iteration
    e_n_1 = []; % A list to store the error at the next iteration
…        end
    end
    loglog(e_n, e_n_1,'o-'); % Plot the relationship between e_n and e_n+1
    xlabel('e_n');
    ylabel('e_n+1');
    title('e_n+1 as a function of e_n');
    xroot = x_1; %The function newton return value is saved in the variable xroot.
    fprintf('e_n: %f \n,e_n_1: %f \n',e_n,e_n_1)
end
