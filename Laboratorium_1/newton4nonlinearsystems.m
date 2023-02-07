%Detta är lösningen till uppgift 2b sitter och håller på med c i skrivande
%stund.

function Xrot = newton_method(X, a, b, ra, rb, tol) 
   F = @(X) [(X(1) - a(1))^2 + (X(2) - a(2))^2 - ra^2;
             (X(3) - b(1))^2 + (X(4) - b(2))^2 - rb^2;
             (X(1) - X(3)) * (X(1) - a(1)) + (X(2) - X(4)) * (X(2) - a(2));
             (X(1) - X(3)) * (X(3) - b(1)) + (X(2) - X(4)) * (X(4) - b(2))]; %Beräkna vår F(X), kom ihåg X1 definerades som att ha två punkter (x1,y2), och X2 hade på motsvarande sätt punkterna (x2,y2). Så när vi har X(1) får vi X(1)=x1 och för X(3) har vi X(3)=x2 osv.
  
   J=@(X) [2*(X(1)-a(1)),2*(X(2)-a(2)),0,0; % Beräkna vår jacobian, dvs förändringsmatrisen.
           0,0,2*(X(3)-b(1)),2*(X(4)-b(2));
           2*(X(1)-X(3)) + (X(1)-a(1)),2*(X(2)-X(4)) + (X(2)-a(2)),-(X(1)-X(3)) - (X(1)-a(1)),-(X(2)-X(4)) - (X(2)-a(2));
           X(3)-b(1),X(4)-b(2),-(2*X(3)-X(1)-b(1)),-(2*X(4)-X(2)-b(2))];
   error = Inf; % Initialt är felet satt som oändligheten
   iter = 0; % Iterationen är satt till 0
   while error > tol %Medans felet är större än toleransen
       F_val = F(X); %Bara variabelbyte
       J_val = J(X); % Samma här
       delta = -J_val \ F_val; % Räkna ut delta i boken är symbolen δ
       X = X + delta; % Räknar ut den nya vektorn X
       error = norm(delta); % Normerar delta
       iter = iter + 1; % Ökar iterationen med 1 
       if error <= tol % Om felet är mindre än toleransen så följer nedan kod
           Xrot = X; % Funktionens returnvärde sparas i Xroot
           fprintf('Root found: [%f, %f, %f, %f]\n', X(1), X(2), X(3), X(4)); % printar den slutliga vektor roten
           break;
       end
       fprintf('Iteration: %d, Error: %e, Root: [%f, %f, %f, %f]\n', iter, error, X(1), X(2), X(3), X(4)); % Printar alla iterationer 
   end
   
 
x = -4:0.04:3; %Godtyckligt intervall för x axeln för grafen som vi skall skapa
y = -4:0.04:2; % Godtyckligt intervall för y-axeln för grafen som vi skall skapa
[X,Y] = meshgrid(x,y); % Skala ihop dem

figure;
hold on;
viscircles([-2, 2], 1.3); % FÖRSTA CIRKELN 
viscircles([1, 0], 0.6); % ANdra cirkeln
deltax=Xrot(3)-Xrot(1); %Vi har erhållit en slutlig vektor som lösning, vi använder den för att skapa linjen, först räknar vi skillnaden i x-led
deltay=Xrot(4)-Xrot(2); % Sedan i y-led
deltak=deltay/deltax; %Nu erhåller vi k-värdet dvs lutningen
m=Xrot(2)-deltak*Xrot(1); %Nu söker vi skärningspunkten med y-axeln
y=deltak*x+m; % vi skapar vår linje
plot(x,y); % Slutligen plottar vi den
hold off;

end
