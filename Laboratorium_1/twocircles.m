function Xrot = newton_method(X, ra, rb, a, b, tol) 
  
    close all
    figure()
    F = @(X) [(X(1) - a(1))^2 + (X(2) - a(2))^2 - ra^2;
             (X(3) - b(1))^2 + (X(4) - b(2))^2 - rb^2;
             (X(1) - X(3)) * (X(1) - a(1)) + (X(2) - X(4)) * (X(2) - a(2));
             ((X(1) - X(3)) * (X(3) - b(1))) + ((X(2) - X(4)) * (X(4) - b(2)))];
   maxiter=300;
   J=@(X) [2*(X(1)-a(1)),2*(X(2)-a(2)),0,0;
…    
   
   viscircles(a,ra,'EdgeColor', 'blue');
   viscircles(b,rb,'EdgeColor', 'yellow');
   hold on
   plot([Xrot(1) Xrot(3)], [Xrot(2) Xrot(4)], '-', 'Color', 'black', 'LineWidth', 2);
   hold off
   
end
