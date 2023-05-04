%-----beräkna ny S0 med störda felgränserna------

S0=[ 1.10 -0.19 -0.37 -0.55;
      -0.18  1.11 -0.15 -0.77;
      -0.38 -0.16  0.95 -0.40;
      -0.57 -0.80 -0.42  1.75];

k_normal=perturbation(S0);

%Pawan 1!----------------------------------


k_difference=zeros(5,1);
for i = 1:size(S0,1)
    for j = 1:size(S0,2)
        %element = S0(i,j)+0.02;
        element = S0(i,j)*1.02;
        S_stord=S0;
        S_stord(i,j)=element;
        k_stord=perturbation(S_stord);
        k_difference=k_difference+abs(k_normal-k_stord);
        % do something with the element here
    end
end
index=max(k_difference);


a=sum(k_difference);

disp(['Felgränsen är ungefär: ' num2str(a*100,2),'%']);

%----------- 1/rij-->kij , Iij

k_difference

