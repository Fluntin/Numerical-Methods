function S = ResponsMatrix(k)
% k: vektor med konduktanser
% S: responsmatrisen f ̈or det givna n ̈atverket
n = 6; % antal noder
m = 4; % antal yttre noder
% ber ̈akna delmatriserna
K = KirchhoffMatrix(k);
K11 = K(1:m,1:m);
K12 = K(1:m,m+1:n);
K21 = K(m+1:n,1:m);
K22 = K(m+1:n,m+1:n);
% ber ̈akna responsmatrisen
S = K11 - K12*(K22\K21);
end


