plant = tf(1,[1 0 0]);
Ts = 0.1;
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);
mpcobj.MV = struct('Min',-1,'Max',1);
if ~mpcchecktoolboxinstalled('simulink')
    disp('Simulink(R) is required to run this example.')
    return
end
mdl = 'mpc_doubleint';
open_system(mdl);
sim(mdl);
%bdclose(mdl)
