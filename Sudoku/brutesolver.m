function [ final,it ] = brutesolver( start )
%BRUTESOLVER Summary of this function goes here
%   Detailed explanation goes here
ge = ones(9,9);
it = 0;
good = false;
test=ones(9,9);

while not(good)
    for i = 1:9
        for j = 1:9
            if start(i,j)~=0
                test(i,j)=start(i,j);
            else
                test(i,j)=ge(i,j);
            end
        end
    end
    
    good = sudokutest(test);
    
    if good
        final = test;
    else
        ge = genguess(ge);
        it = it + 1;
    end
end 

end

