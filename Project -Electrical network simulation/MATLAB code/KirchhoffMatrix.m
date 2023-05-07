function K = KirchhoffMatrix(k)
% k: vektor med konduktanser
% K: Kirchoffmatrisen f ̈or det givna n ̈atverket
%k=(k_{15}, k_{26}, k_{56}, k_{35}, k_{46})^T
n = 6; % antal noder
K = zeros(n); % initialisera K-matrisen
% fyll i Kirchoffmatrisen
K(1,1) = k(1);
K(2,2) = k(2);
K(3,3) = k(4);
K(4,4) = k(5);
K(5,5) = k(1)+k(4)+k(3);
K(6,6) = k(3)+k(2)+k(5);
K(1,5)= -k(1);
K(5,1)= -k(1);
K(2,6) = -k(2);
K(6,2) = -k(2);
K(5,6) = -k(3);
K(6,5) = -k(3);
K(3,5) = -k(4);
K(5,3) = -k(4);
K(4,6) = -k(5);
K(6,4) = -k(5);
end





