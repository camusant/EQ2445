function [x1,G1,xup,Gup] = linearKalman(x0,G0,u,y,Galpha, GBeta, A,C)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if (isempty(y)) % When no output
    n = length(x0);
    y = eye(0,1); GBeta = eye(0,0); C = eye(0,n);    
end
S = C * G0 * C' + GBeta;
K = G0*C'\S;
ytilde = y -C * x0;
xup = x0 + K * ytilde;
Gup = G0 - K*C*G0;
x1 = A * xup +u;
G1 = A * Gup *A' +Galpha;
end

