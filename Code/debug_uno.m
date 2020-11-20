ct = linspace(0,30,1000);
debugu=0;
for i=1:1000
    
    debugu(i)=1-exp(-ct(i)/21.6404);
    
end

plot(ct,debugu);