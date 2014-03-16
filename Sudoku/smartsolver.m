function [ final, it] = smartsolver( start )
%SMARTSOLVER Summary of this function goes here
%   Detailed explanation goes here
[final,res,it] = solverfunction(start,1,0);

if res ~= true
    disp('Error')
end

end

