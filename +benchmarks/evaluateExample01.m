function g = evaluateExample01(X)
%EVALUATEEXAMPLE01 Noisy limit-state function, paper Eq. (24).
linearPart = X(:,1)+2*X(:,2)+2*X(:,3)+X(:,4)-5*X(:,5)-5*X(:,6);
g = linearPart + 0.001*sum(sin(100*X),2);
end
