x= [0:0.01:8];
%y=x.^2-x.*8-5*sin(3*x+1)+12;
plot(x,y(x)), hold on,
%plot(x,0, "red")
yline(0)

roots=findroots(0,100,10);
plot(roots,0,'-o')

"Antal nollställen"
length(roots)

fixedpointiteration(4, 10^(-10));

%roots - fzero----------------------------------------------------------------------
function found_roots=findroots(start,k,slut)
% start= beginning of the interval
% slut = end of the interval
% k = in how many search areas the interval is devided in

jump=(slut-start)/(k-1);
points=start:jump:slut;

candidate_point=[];
candidate_point(1)=start;

for i = 1:(length(points)-1)

    if g(points(i))*g(points(i+1))<0
      
        candidate_point(end+1)=points(i+1);

    end

end

%candidate_point

found_roots= [];
eqn= @(x) x^2-x*8-5*sin(3*x+1)+12;

for j = 1:(length(candidate_point)-1)
    
    found_roots(end+1)= fzero(eqn,[candidate_point(j),candidate_point(j+1)]);

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
