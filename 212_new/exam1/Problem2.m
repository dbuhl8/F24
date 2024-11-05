% Enter input parameters
L = 1;   % Length of interval
D = 1;   % Wave speed
tf = 10;  % Final time 
nf = 40; % Number of Fourier modes to keep
nx = 200; % Number of meshpoints to keep
nt = 100;  % Number of time points to print

mesh = linspace(0,L,nx);
time = linspace(0,tf,nt);

% Calculate various quantities of interest.
for n=1:nf
    func = (1-mesh/L).*sin(n*pi*mesh/L);
    a(n) = (2/L)*trapz(mesh,func);
    lambda(n) = n^2*pi^2*D/L^2;
end

for i=1:nt
    for j=1:nx
         sum = (1-mesh(j)/L)*forcing(time(i));
         for n=1:nf
            timefun = @(tp) -exp(lambda(n)*(tp-time(i))).*dforcing(tp);
            term = integral(timefun,0,time(i));
            sum = sum + a(n)*sin(n*pi*mesh(j)/L)*term;
        end
        sol(j,i) = sum;
    end
    plot(mesh,sol(:,i));
    xlim([0 L]);
    ylim([-4 4]);
    M(i) = getframe;
end

movie(M);


function res = forcing(t)
%This is F(t)
res = sin(4*pi*t);
end


function res = dforcing(t)
%This is dF/dt(t)
res = 4*pi*cos(4*pi*t);
end
