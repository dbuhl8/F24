close all; clear; clc; 

% plot the approximation for different values of epsilon and keeping a finite number of taylor terms. See how the approximation holds up. 

t = 0:0.01:5;

epsilon = 0.4;


fa = exp(-(t.^2)/2 - epsilon*t);
f0 = exp(-(t.^2)/2);
f1 = exp(-(t.^2)/2).*(1 - epsilon.*t);
f2 = exp(-(t.^2)/2).*(1 - epsilon.*t + (epsilon^2)*(t.^2));

[dt,dy] = ode45(@(x,f) -(x+epsilon).*f, [0,5], [1]);

plot(t,fa,'b',t,f0,'c',t,f1,'g',t,f2,'m',dt,dy,'r--','LineWidth',2)
legend('Actual', 'T_0','T_1','T_2','Numerical')
title('$\epsilon = 0.4$','fontsize',20,'interpreter','latex')
xlabel('Time','fontsize',15')
