function [ ge ] = genguess( ge )
%GENGUESS Summary of this function goes here
%   Detailed explanation goes here
ge(9,9) = ge(9,9) + 1;

for i = 9:-1:1
    for j = 9:-1:1
        if ge(i,j)==10
            ge(i,j)=1;
            if j == 1
                ge(i-1,9)=ge(i-1,9)+1;
            else
                ge(i,j-1)=ge(i,j-1)+1;
            end
        end
    end
end

end

