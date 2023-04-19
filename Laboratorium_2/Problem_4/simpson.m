function V = simpson(n)
    %Öppning med radien R=3
    R = 3;

    %Definerad i uppgiften
    V0 = g(R) * R^2 * pi;

    %Duljina koraka
    h = R / n;


    sum_jamnt = 0;
    sum_udda = 0;
    
    for i = 1:(n-1)
        r = i * h;
        if mod(i, 2) == 0
            sum_jamnt = sum_jamnt + g(r)*r;
            %sum_jamnt = sum_jamnt + g(r);
        else
            sum_udda = sum_udda + g(r)*r;
            %sum_udda = sum_udda + g(r);
        end
    end
    
    V = V0 - (2 * pi * h/3 * (g(0)*0 + 4 * sum_udda + 2 * sum_jamnt + g(R)*R) );
    
    function res = g(r)
        res = (3 * r^3 * exp(-r)) / (1 + (1/3) * sin((8 * r) / 5));
    end
end