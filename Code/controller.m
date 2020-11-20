function control = controller(ref, conc_glucose)

K = 1;
control = K*(ref - conc_glucose);