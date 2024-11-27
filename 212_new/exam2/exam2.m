clear; close all; clc; 

%ODE A: epsilon = 0 corresponds to the solution f = cos(t)
t = 0:0.00001:50;

% this can be transcribed to a 2 dimensional 1st order ODE problem rather than a 1 dimensional 2nd order ODE

[t,y1] = ode45(@odeA1, t, [1 0]);
[t,y2] = ode45(@odeA2, t, [1 0]);
[t,y3] = ode45(@odeA3, t, [1 0]);

s = size(y1);

plot(t,y1(:,1),'red',t,y2(:,1),'blue',t,y3(:,1),'black')
hold on
%asym = @(x, ep) cos(x) + ep*(-x.*cos(x)/8 - sin(3*x)/32 + 7*sin(x)/32)
asym = @(x, ep) cos(x).*((ep*x/4 + 1).^(-0.5))
plot(t,asym(t,0.1),'r--',t,asym(t,0.01),'b--',t,asym(t,0.001),'k--',LineWidth=2)
legend('$\epsilon = 0.1$', '$\epsilon = 0.01$', '$\epsilon = 0.001$', 'Interpreter', 'latex', 'FontSize', 20)
ylim([-1 1.5])
xlabel('Time', 'FontSize', 20)
title('ODE A', 'FontSize', 20)
saveas(gcf,'ODEA.pdf')

hold off

figure()
semilogy(t,abs(y1(:,1)-asym(t,0.1)),'r',t,abs(y2(:,1)-asym(t,0.01)),'b',t,abs(y3(:,1)-asym(t,0.001)),'k')


%ODE B
figure();
[t,y1] = ode45(@odeB1, t, [1 0]);
[t,y2] = ode45(@odeB2, t, [1 0]);
[t,y3] = ode45(@odeB3, t, [1 0]);

plot(t,y1(:,1),'red',t,y2(:,1),'blue',t,y3(:,1),'black')
hold on
asym = @(x, ep) cos((1+ep/16)*x)
plot(t,asym(t,0.1),'r--',t,asym(t,0.01),'b--',t,asym(t,0.001),'k--',LineWidth=2)
legend('$\epsilon = 0.1$', '$\epsilon = 0.01$', '$\epsilon = 0.001$', 'Interpreter', 'latex', 'FontSize', 20)
ylim([-1 1.5])
%xlim([900,1000])
xlabel('Time', 'FontSize', 20)
title('ODE B', 'FontSize', 20)
saveas(gcf,'ODEB.pdf');
hold off

figure()
semilogy(t,abs(y1(:,1)-asym(t,0.1)),'r',t,abs(y2(:,1)-asym(t,0.01)),'b',t,abs(y3(:,1)-asym(t,0.001)),'k')

%ODE C (this problem requires some matlab intrinsic or at least a shooting method in order to ensure the initial conditions: f(0) = 1, f(1) = 2
t = 0:0.00001:1;
figure()
dya = -1;
dyb = 1;
[t,y1a] = ode45(@odeC1, t, [1 dya]);
[t,y1b] = ode45(@odeC1, t, [1 dyb]);
% change initial condition to get closer to the boundary
ea = 2-y1a(end,1);
eb = 2-y1b(end,1);
while (eb > 10^(-7))
    temp = dyb;
    dyb = dyb - eb*(dyb-dya)/(eb-ea);
    dya = temp;
    ea = eb;
    [t,y1b] = ode45(@odeC1, t, [1 dyb]);
    eb = 2-y1b(end,1);
end 
dya = -1;
dyb = 1;
[t,y2a] = ode45(@odeC2, t, [1 dya]);
[t,y2b] = ode45(@odeC2, t, [1 dyb]);
% change initial condition to get closer to the boundary
ea = 2-y2a(end,1);
eb = 2-y2b(end,1);
while (eb > 10^(-7))
    temp = dyb;
    dyb = dyb - eb*(dyb-dya)/(eb-ea);
    dya = temp;
    ea = eb;
    [t,y2b] = ode45(@odeC2, t, [1 dyb]);
    eb = 2-y2b(end,1);
end 
dya = -1;
dyb = 1;
[t,y3a] = ode45(@odeC3, t, [1 dya]);
[t,y3b] = ode45(@odeC3, t, [1 dyb]);
% change initial condition to get closer to the boundary
ea = 2-y3a(end,1);
eb = 2-y3b(end,1);
while (eb > 10^(-7))
    temp = dyb;
    dyb = dyb - eb*(dyb-dya)/(eb-ea);
    dya = temp;
    ea = eb;
    [t,y3b] = ode45(@odeC3, t, [1 dyb]);
    eb = 2-y3b(end,1);
end 


asym = @(x, ep) (1 - 2*exp(1.5))*exp(-x/ep) + 2*exp(1.5 -(x.^2)/2 - x)
plot(t,y1b(:,1),'red',t,y2b(:,1),'blue',t,y3b(:,1),'green')
hold on
plot(t,asym(t,0.1),'r--',t,asym(t,0.01),'b--',t,asym(t,0.001),'k--',LineWidth=2)
legend('$\epsilon = 0.1$', '$\epsilon = 0.01$', '$\epsilon = 0.001$', 'Interpreter', 'latex', 'FontSize', 20)
%ylim([-1 1.5])
xlabel('Time', 'FontSize', 20)
title('ODE C', 'FontSize', 20)
saveas(gcf,'ODEC.pdf');


function dydt = odeA1(t,y) 
    dydt = [y(2); -y(1) - 0.1*(y(1)^2)*y(2)];
end
function dydt = odeA2(t,y) 
    dydt = [y(2); -y(1) - 0.01*(y(1)^2)*y(2)];
end
function dydt = odeA3(t,y) 
    dydt = [y(2); -y(1) - 0.001*(y(1)^2)*y(2)];
end


function dydt = odeB1(t,y) 
    dydt = [y(2); -y(1) - 0.1*y(1)*(y(2)^4)];
end
function dydt = odeB2(t,y) 
    dydt = [y(2); -y(1) - 0.01*y(1)*(y(2)^4)];
end
function dydt = odeB3(t,y) 
    dydt = [y(2); -y(1) - 0.001*y(1)*(y(2)^4)];
end


function dydt = odeC1(t,y) 
    dydt = [y(2); (-y(2) - (t+1)*y(1))/0.1];
end
function dydt = odeC2(t,y) 
    dydt = [y(2); (-y(2) - (t+1)*y(1))/0.01];
end
function dydt = odeC3(t,y) 
    dydt = [y(2); (-y(2) - (t+1)*y(1))/0.001];
end

