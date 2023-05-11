function F = F_vector(k, S0)

  S = ResponsMatrix(k);
  F = S - S0;
  F = F(:);  % omforma F till en vektor
end