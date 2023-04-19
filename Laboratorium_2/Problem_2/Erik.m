function [xn, xm, ym] = Erik(h, typ)
    [T,X,Y,VX,VY] = kastbana(h);
    if typ == 1
        n = length(X);
        D = ones(n-1,2);
        for i = 1:n-1
            V=[ones(2,1), X(i:i+1)-X(i)];
            d = V\(Y(i:i+1)-Y(i));
            D(i,:) = d';  
        end
        % D(:,2) lutningar
        
        %Finding max
        %not complete or maybe
        [ym, idxMax] = max(Y);
        xm = X(idxMax);
        
        %Finding xn
        idNegative = find(Y< 0, 1, 'first');
  
        % Where the secant intersects y=0, going backwards
        xn= X(idNegative)-Y(idNegative)/D(idNegative-1,2);
        
    end
 if typ== 2
     % finding max
        
     [yM, idxMax] = max(Y);
     V = [ones(3,1), X(idxMax-1:idxMax+1), X(idxMax-1:idxMax+1).^2];
    
     d = V\Y(idxMax-1:idxMax+1); 
     xm = -d(2)/(d(3)*2);
     ym = xm^2*d(3)+ xm*d(2) + d(1);
  
    
​
     %Finding 0
​
     idNegative = find(Y< 0, 1, 'first');
     V = [ones(3,1), X(idNegative-2:idNegative), X(idNegative-2:idNegative).^2];
     d = V\Y(idNegative-2:idNegative);
​
     xn = -d(2)/(d(3)*2)+sqrt((d(2)/(d(3)*2))^2-d(1)/d(3));
       
     
​
 end
​
​
    
    end