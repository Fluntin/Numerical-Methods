Uppgift 2b


function Xrot = newton_method(X, ra, rb, a, b, tol) 
   F = @(X) [(X(1) - a(1))^2 + (X(2) - a(2))^2 - ra^2;
             (X(3) - b(1))^2 + (X(4) - b(2))^2 - rb^2;
             (X(1) - X(3)) * (X(1) - a(1)) + (X(2) - X(4)) * (X(2) - a(2));
             (X(1) - X(3)) * (X(3) - b(1)) + (X(2) - X(4)) * (X(4) - b(2))];
   maxiter=30;
   J=@(X) [2*(X(1)-a(1)),2*(X(2)-a(2)),0,0;
           0,0,2*(X(3)-b(1)),2*(X(4)-b(2));
           2*(X(1)-X(3)) + (X(1)-a(1)),2*(X(2)-X(4)) + (X(2)-a(2)),-(X(1)-X(3)) - (X(1)-a(1)),-(X(2)-X(4)) - (X(2)-a(2));
           X(3)-b(1),X(4)-b(2),-(2*X(3)-X(1)-b(1)),-(2*X(4)-X(2)-b(2))];
   error = Inf;
   iter = 0;
   while ((error > tol)&&(iter<=maxiter))
       F_val = F(X);
       J_val = J(X);
       delta = -J_val \ F_val;
       Xn = X + delta;
       error = norm(Xn-X,2);
       X=Xn;
       iter = iter + 1;
       fprintf('Iteration: %d, Error: %e, Root: [%f, %f, %f, %f]\n', iter, error, X(1), X(2), X(3), X(4));
   end
   Xrot = X;
   fprintf('Final root: [%f, %f, %f, %f]\n', X(1), X(2), X(3), X(4)); % Prints the final root vector
    
   
   figure()
   hold on
   viscircles(a,ra,'EdgeColor', 'blue');
   viscircles(b,rb,'EdgeColor', 'yellow');
   hold on
   plot([Xrot(1),Xrot(3)], [Xrot(2),Xrot(4)], '-', 'Color', 'black', 'LineWidth', 2);
   hold off
   
end
