function F = F_vector(k, S0)

  S = ResponsMatrix(k);
  F = S - S0;
  F = F(:);  % omforma F till en vektor
end
%creates the vector valued function that is necessary for the gauss-newton 
% in main file
