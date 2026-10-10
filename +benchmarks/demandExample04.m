function demand = demandExample04(X)
%DEMANDEXAMPLE04 Modified Ishigami response, paper Eq. (27).
demand = sin(X(:,1)) + 7*sin(X(:,2)).^2 ...
    + 0.1*X(:,3).^4.*sin(X(:,1));
end
