function [ good ] = sudokutest(test)
%SUDOKUTEST Summary of this function goes here
%   Detailed explanation goes here
good = true;

for i = 1:9
    if or(mode(test(i,:))~=0,mode(test(:,i)))
        good = false;
    end

end

for i = 1:3:7
    for j = 1:3:7
        if mode([test(i,j:(j+2)),test(i+1,j:(j+2)),test(i+2,(j:j+2))])~=0
            good = false;
        end
    end
end

end