function xk1 = pancStateFcn(xk, u)

uk = u(1);
Ts = u(2);
ct = u(3);

param = [Ts,ct];
xk1 = pancDT(xk, uk, param);
