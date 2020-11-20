%% Save all of the constants to the workspace 

global k_12;
global k_a1;
global k_a2;
global k_a3;
global k_e;
global v_i;
global v_g;
global a_g;
global tmax_g;

k_12 = 0.066;
k_a1 = 0.006;
k_a2 = 0.06;
k_a3 = 0.03;
k_e = 0.138;
v_i = 0.12;
v_g = 0.16;
a_g = 0.8;
tmax_g = 40;

%% Parameters fixed w.r.t the paper


global s_it;
global s_id;
global s_ie;

global k_b1;
global k_b2;
global k_b3;

global egp_0;
global f_01;
global tmax_i;


s_it = 51.2e-4;
s_id = 8.2e-4;
s_ie = 520e-4;

k_b1 = s_it * k_a1;
k_b2 = s_id * k_a2;
k_b3 = s_id * k_a3;

egp_0 = 0.0161;
f_01  = 0.0097;
tmax_i = 55;

%%global meal_time;
%%global d_g;

%d_g = [1,0.3,0.1,0.4]; %ammount of carbohydrates digested
%meal_time = [20,70,150,250];








