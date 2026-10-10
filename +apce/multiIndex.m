function alpha = multiIndex(d, p)
%MULTIINDEX Total-degree multi-indices in graded lexicographic order.
%   ALPHA = apce.multiIndex(D,P) returns one row for every monomial in D
%   variables having total degree no greater than P.  The constant term is
%   first.  For D=2 and P=2, the rows are [0 0], [1 0], [0 1], [2 0],
%   [1 1], and [0 2].

validateattributes(d, {'numeric'}, {'scalar','integer','positive'});
validateattributes(p, {'numeric'}, {'scalar','integer','nonnegative'});

alpha = zeros(nchoosek(d + p, p), d);
next = 1;
for degree = 0:p
    block = exactDegree(d, degree);
    alpha(next:next + size(block,1) - 1, :) = block;
    next = next + size(block,1);
end
end

function block = exactDegree(d, degree)
if d == 1
    block = degree;
    return
end

block = zeros(nchoosek(d + degree - 1, degree), d);
next = 1;
for firstPower = degree:-1:0
    tail = exactDegree(d - 1, degree - firstPower);
    count = size(tail,1);
    block(next:next + count - 1, :) = [repmat(firstPower,count,1), tail];
    next = next + count;
end
end
