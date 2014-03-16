function [test,good] = recursolver( start, test, r, c )
%RECURSOLVER Summary of this function goes here
%   Detailed explanation goes here
if start(r,c) ~= 0
    test(r,c) = start(r,c);
else
    for i = 1:9
        test(r,c) = i;
        if sudokutest(test)
            if c ~= 9
                [test,g1] = recursolver(r,c+1);
            else
                [test,g1] = recursolver(r+1,1);
            end
        else

end

