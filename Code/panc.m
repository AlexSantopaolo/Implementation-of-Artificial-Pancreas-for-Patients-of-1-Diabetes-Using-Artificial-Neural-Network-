function dydt = panc(x,u,t)

q_1 = x(1);
q_2 = x(2);
s_1 = x(3);
s_2 = x(4);
I   = x(5);
x_1 = x(6);
x_2 = x(7);
x_3 = x(8);

global k_12;

global tmax_i;
global v_g;

global k_a1;
global k_a2;
global k_a3;

global k_b1;
global k_b2;
global k_b3;
global k_e;
global v_i;
global egp_0;

%global txx;

g = q_1/v_g;
U_i = s_2/tmax_i; 

%u = 1; %The administration of insulin (flow rate)

% u = controller(5.5,g);

t
u_g(t)

dydt = [-f_01_c(g) - x_1*q_1 + k_12*q_2 - f_r(g) + u_g(t) + egp_0*(1 - x_3); 
        x_1*q_1 - (k_12+ x_2)*q_2;   
        u - s_1/tmax_i;   
        s_1/tmax_i - s_2/tmax_i;
        U_i/v_i - k_e*I;
        -k_a1*x_1 + k_b1*I;
        -k_a2*x_2 + k_b2*I;
        -k_a3*x_2 + k_b3*I];


        
    