close all;
clc;
t=linspace(1,200,300);
for i=1:300
    u_gxx(i) = u_g(t(i));
end

plot(t,u_gxx);