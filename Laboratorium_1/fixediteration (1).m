function x_root = fixediteration(x_0, tau)
    MaxIterations = 25;
    currentIterations = 0;
    x_1 = ((x_0)^2)/12 + x_0/3 - 5*sin(3*x_0 + 1)/12 + 1;
    err = abs(x_1 - x_0);
    
    semilogy(currentIterations, err, 'o', 'Color', 'r'); %initialize the plot with the first point
    hold on;
    while ((abs(x_1 - x_0) > tau) && (currentIterations <= MaxIterations))
        x_0 = x_1;
        x_1 = ((x_0)^2)/12 + x_0/3 - 5*sin(3*x_0 + 1)/12 + 1;
        currentIterations = currentIterations + 1;
        err = abs(x_1 - x_0);
        semilogy(currentIterations, err, 'o', 'Color', 'r'); % update the plot with the new point
        fprintf('x_n: %f, |x_n_+_1-x_n| : %f\n', x_1, abs(x_1-x_0));
    end
    xlabel('Iteration');
    ylabel('Error');
    title('Fixed Point Iteration Convergence');
    legend('Error');
    if abs(x_1 - x_0) <= tau
        fprintf('Final root x is: %f\n', x_1);
        x_root = x_1;
    else
        x_root = NaN;
        fprintf('Method failed to converge within %d iterations.\n', MaxIterations);
    end
end

function [xrot] = newton(x_0, tau)
    MaxIterations = 13; % maximum number of iterations
    iterations = 0;
    f = @(x) x^2-8*x-5*sin(3*x+1)+12; % function
    deriv = @(x) -15*cos(3*x+1)+2*x-8; % derivative of function
    x_1 = x_0-feval(f,x_0)/feval(deriv,x_0); % Newton's method
    diff = []; % to store the absolute difference between iterations
    while iterations <= MaxIterations
        x_0 = x_1; % update x_0
        x_1 = x_0-feval(f,x_0)/feval(deriv,x_0); % update x_1
        diff = [diff, abs(x_1-x_0)]; % store the absolute difference between iterations
        iterations = iterations+1;
        fprintf('x_n: %f, diff: %f\n', x_1, diff(iterations));
        if diff(iterations) < tau % check if difference is less than tolerance
            break;
        end
    end
    semilogy(1:iterations, diff, 'o-'); %
end



