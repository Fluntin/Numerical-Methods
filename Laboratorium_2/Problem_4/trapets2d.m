function V = trapets2d(n)
    % Parametrar
    %64
    R = 3;
    L = 3 * sqrt(2);
    h = L / n;

    % Function g(r)
    g = @(r) (3 .* r.^3 .* exp(-r)) ./ (1 + (1/3) .* sin((8 .* r) ./ 5));
    
    % Double integral
    V = 0;
    for i = 0:(n-1)
        for j = 0:(n-1)
            x = -L/2 + (i + 0.5) * h;
            y = -L/2 + (j + 0.5) * h;
            V = V + (g(R) - g(sqrt(x^2 + y^2))) * h^2;
        end
    end
end


