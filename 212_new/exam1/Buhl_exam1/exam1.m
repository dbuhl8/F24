x = 1:0.01:2;
x1 = 1.25;

g1 = zeros(size(x));

for i = 1:50
    g1 = g1 - ((2*log(2))/(i^2*pi^2))*(sin(i*pi*log(x)/log(2))*sin(i*pi*log(x1)/log(2))/x1)
end 

for i = 1:length(x)
    if x(i) < x1 
        g2(i) = (log(x1)/(x1*log(2)) - 1/x1)*log(x(i));
    else
        g2(i) = (log(x1)/(x1*log(2)))*log(x(i)) - log(x1)/x1;
    end
end

plot(x, g1,'r--', x, g2,'bo');
legend('Eigenfunction Expansion', 'Patching');
ax.FontSize = 20;
