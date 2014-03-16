function [ test, res, it ] = solverfunction( test, num, it )
%SOLVERFUNCTION Summary of this function goes here
%   Detailed explanation goes here

r=round(0.6:0.11:9.5);
c=[1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9];
res = false;

if test(r(num),c(num))~=0
    [test,res,it] = solverfunction(test, num+1,it);
else
    for i = 1:9
        it = it + 1;
        test(r(num),c(num))=i;
        good = sudokutest(test);
        if and(good == true, num < 81)
            [test,res,it] = solverfunction(test, num+1,it);
            if res == true
                break
            end
        elseif and(good == true, num == 81)
            res = true;
            break
        end
    end
    if res == false
        test(r(num),c(num))=0;
    end
end
            


end

