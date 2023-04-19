function V = trapets(n)
    %Öppning med radien R=3
    R = 3;
    
    %Definerad i uppgiften
    V0 = g(R) * R^2 * pi;

    %Duljina koraka
    h = R / n;

    %Endast först och sista /2
    sum = (g(0)*0 + g(R)*R) / 2;
    
    for i = 1:(n-1)
        %position of each node is this the same r as in formula
        r = i * h;
        sum = sum + g(r)*r;
        %sum = sum + g(r);
    end
    %Enkelintegra
    V = V0 - 2 * pi *  sum * h;
    
    %Kontur beskrivs av funktionen
    function res = g(r)
        res = (3 * r^3 * exp(-r)) / (1 + (1/3) * sin((8 * r) / 5));
    end
end