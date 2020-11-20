function out = u_g(t)

global a_g;
global tmax_g;
global d_g;
global meal_time;
out=0;
for i=1:length(meal_time)
    t_m=t;
    if t_m>=meal_time(i)
    t_m = t_m - meal_time(i);
    out = out + (d_g(i).*a_g.*t_m.*exp(-(t_m./tmax_g)))./(tmax_g^2);
    end
end
