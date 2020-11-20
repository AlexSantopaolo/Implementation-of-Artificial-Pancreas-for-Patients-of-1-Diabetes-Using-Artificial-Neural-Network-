function dydt = ales( t,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

beh = y(1);
dydt = [y(2); myForce(beh) - 2*y(2)];

end

