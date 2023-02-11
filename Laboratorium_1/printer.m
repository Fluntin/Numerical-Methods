%denna är deluppgift för uppgift 2c. Den ritar cirklarna och repet runt dem. 
  
function printed=printer()
clc
close all
figure()

X0 = [3; 4; 7; 3.4];
X1 = [-1.4; 1.6; -1; -2];
X2 = [3.8; -0.3; 1.6; -2.5];

ra = 0.9;
rb = 1.4;
rc = 0.6;
a = [0.0; 1.3]';
b = [3; 0.5]';
c = [0.5; -2.0]';
tau = 10^-10;
XROT_AB = punkter(X0, ra, rb, a, b, tau);
XROT_BC = punkter(X1, ra, rc, a, c, tau);
XROT_AC = punkter(X2, rb, rc, b, c, tau);

hold on
viscircles(a,ra,'EdgeColor', 'blue');
viscircles(b,rb,'EdgeColor', 'yellow');
viscircles(c,rc,'EdgeColor', 'red');
text(c(1) + 0.15, c(2), "C");
text(b(1) + 0.15, b(2), "B");
text(a(1) + 0.15, a(2), "A");

hold on
plot(XROT_AB(1), XROT_AB(2), "k*");
plot(XROT_AB(3), XROT_AB(4), "k*");
plot([XROT_AB(1),XROT_AB(3)], [XROT_AB(2),XROT_AB(4)], '-', 'Color', 'black', 'LineWidth', 2);



hold on
plot(XROT_AC(1), XROT_AC(2), "k*");
plot(XROT_AC(3), XROT_AC(4), "k*");
plot([XROT_AC(1),XROT_AC(3)], [XROT_AC(2),XROT_AC(4)],'-', 'Color', 'c', 'LineWidth', 2);

hold on
plot(XROT_BC(1), XROT_BC(2), "k*");
plot(XROT_BC(3), XROT_BC(4), "k*");
plot([XROT_BC(1),XROT_BC(3)], [XROT_BC(2) XROT_BC(4)],'-', 'Color', 'green', 'LineWidth', 2);


%Punkterna på cirklen A som skapas av A->B och A->C
dxA=(XROT_AB(1)-XROT_AC(1));
dyA=(XROT_AB(2)-XROT_AC(2));
angleA = atan2(dyA, dxA);
arc_lengthA = ra * angleA;


%Punkterna på cirkeln B som skapas av A->B och B->C
dxB=(XROT_BC(1)-XROT_AB(3));
dyB=(XROT_AB(4)-XROT_BC(2));
angleB = atan2(dyB, dxB);
arc_lengthB = ra * angleB;


%Punkterna på cirklen C som skapas av A->C och B->C
dxC=(XROT_BC(3)-XROT_AC(3));
dyC=(XROT_AC(4)-XROT_BC(4));
angleC = atan2(dyC, dxC);
arc_lengthC = rc * angleC;
sum_of_arcs=arc_lengthA+arc_lengthB+arc_lengthC;

distancelineAB = sqrt((XROT_AB(1) - XROT_AB(3))^2 + (XROT_AB(2) - XROT_AB(4))^2);
distancelineAC = sqrt((XROT_AC(1) - XROT_AC(3))^2 + (XROT_AC(2) - XROT_AC(4))^2);
distancelineBC = sqrt((XROT_BC(1) - XROT_BC(3))^2 + (XROT_BC(2) - XROT_BC(4))^2);

total_length=distancelineAB+distancelineAC+distancelineBC+sum_of_arcs;

fprintf("The total length is: %f\n", total_length);

printed=total_length;

axis("equal")
hold off

end
