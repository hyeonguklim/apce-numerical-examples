function demand = demandExample05(X)
%DEMANDEXAMPLE05 Quadratic response, paper Eq. (29).
x1=X(:,1); x2=X(:,2); x3=X(:,3);
demand = 15 + 4*x1.*x2 + 4*x1.*x3 + 4*x2.*x3 ...
    + 3*x1 + 3*x2 + 3*x3 - x1.^2 - x2.^2 - x3.^2;
end
