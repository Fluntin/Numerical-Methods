x= [0:0.01:8];
%y=x.^2-x.*8-5*sin(3*x+1)+12;
plot(x,y(x)), hold on,
%plot(x,0, "red")
yline(0)

findroots(0,10,100)

fixedpointiteration(4, 10^(-10));

%try with fzero----------------------------------------------------------------------
function found_roots=findroots(start,slut,k)
% start= beginning of the interval
% slut = end of the interval
% k = in how many searh ares the interval is devided in
found_roots= [];
eqn= @(x) x^2-x*8-5*sin(3*x+1)+12;

jump = (slut-start)/k;
cutoof_points(1)=start;

for i=1:k
    cutoof_points(i+1)=cutoof_points(i)+jump;
end
length(cutoof_points)


for j = 1:(length(cutoof_points)-1);
    %if fzero(eqn,[cutoof_points(i),cutoof_points(i+1)]) ~= 'NaN'
    found_roots(end+1)= fzero(eqn,[cutoof_points(j),cutoof_points(j+1)]);
    %end
end
end

%fixedpointiteration----------------------------------------------------

function  xn1= fixedpointiteration(x0, t)
%x0-startgissning
% t-feltolerans

%jump-start
xn=x0;
skillnaden=1;
%----------------------

while skillnaden>t

    xn1=1/12*xn^2+1/3*xn-5/12*sin(3*xn+1)+1;
    skillnaden=abs(xn1-xn);
    xn=xn1;
    g(xn);
    end
end

function y=g(x)
%point imput
y=x^2-x*8-5*sin(3*x+1)+12;
end

function y=y(x)
%array imput
y=x.^2-x.*8-5*sin(3*x+1)+12;
end
