function [ good ] = sudokutest(test)
%SUDOKUTEST Summary of this function goes here
%   Detailed explanation goes here
good = true;

for i = 1:9
    testr = test(i,:);
    testr(testr == 0) = [];
    testc = test(:,i);
    testc(testc == 0) = [];
    
    [~,f1] = mode(testr);
    [~,f2] = mode(testc);
    
    if or(f1>1,f2>1)
        good = false;
    end

end

for i = 1:3:7
    for j = 1:3:7
        testb = [test(i,j:(j+2)),test(i+1,j:(j+2)),test(i+2,(j:j+2))];
        testb(testb == 0) = [];
        [~,f3] = mode(testb);
        if f3>1
            good = false;
        end
    end
end

end