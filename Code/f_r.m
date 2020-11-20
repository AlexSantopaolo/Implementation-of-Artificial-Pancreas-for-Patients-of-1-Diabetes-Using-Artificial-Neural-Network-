function out = f_r(g)

global v_g;


if g>=9
    out = 0.003*(g-9)*v_g;
else
    out = 0;
end