function xk1 = pancDT(xk, uk, param)

Ts = param(1);
k  = param(2);

M = 10;
delta = Ts/M;
xk1 = xk;
for ct=1:M
    val = k*Ts + ct*Ts/M;
    xk1 = xk1 + delta*panc(xk1,uk, val);
end
