
% Numerical solution of the forced problem for 
% x^2f'' + xf' = F(x) in (1,2) with Dirichlet conditions.

% Exact numerical solution for some forcing function (to test that it
% works)
xmesh = linspace(1,2,100);
solinit = bvpinit(xmesh, @guess);
sol = bvp4c(@bvpfcn, @bcfcn, solinit);

figure(1)
plot(sol.x,sol.y(1,:))
nx = size(sol.x,2);
xlabel('x');
ylabel('Numerical Solution');
hold on


% Greens function solution using some forcing (to test that it works) 
for i = 1:nx
    x = sol.x(i);
    arr1 = 0.;
    arr2 = 0.;
    for j = 1:nx
        xp = sol.x(j);
        arr1(j) = greenfunc1(x,xp)*forcing(xp); %Using first Greens function 
        arr2(j) = greenfunc2(x,xp)*forcing(xp); %Using second Greens function
    end
    greensol1(i) = trapz(sol.x,arr1);
    greensol2(i) = trapz(sol.x,arr2);

end
plot(sol.x,greensol1,sol.x,greensol2)
legend('Numerical Solution','Greens solution from eigenfunction expansion','Greens solution from patched solution')

% plotting the GReen's function for 1 value of x;, for examples.
figure(2)
xp = 1.25;  %  fixes x'
for i=1:nx
    g1(i) = greenfunc1(sol.x(i),xp);   
    g2(i) = greenfunc2(sol.x(i),xp);
end
plot(sol.x,g1,sol.x,g2)
xlabel('x')
ylabel('G(x,xp)')
legend('Greens function from eigenfunction expansion','Greens function from patched solution')






function g = guess(x)
g = [sin(pi*x)
     cos(pi*x)];
end

function bcs = bcfcn(ya,yb)
bcs = [ya(1)
       yb(1)];
end

function dydx = bvpfcn(x,y)
dydx = zeros(2,1);
dydx = [y(2)
       -y(2)/x+forcing(x)/x^2];
end

function f = forcing(x)

%f = sin(pi*x);
f = x;
end

function g = greenfunc1(x,xp)

sum = 0;
nmax = 50;
for n=1:nmax
    lambda = n^2*pi^2/(log(2)^2);
    sum = sum-2.*sin(n*pi*log(x)/log(2)).*sin(n*pi*log(xp)/log(2))/(xp*lambda*log(2));
end
g = sum;
end

function g = greenfunc2(x,xp)

cl = log(xp/2)/(xp*log(2));
cr = cl + 1./xp;
dr = -cr*log(2);

if(x<xp)
    g=cl*log(x);
else
    g=cr*log(x)+ dr;
end
end



