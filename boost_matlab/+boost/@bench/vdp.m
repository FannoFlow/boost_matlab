function t = vdp(n)
%VDP Summary of this function goes here
%   Detailed explanation goes here
arguments
n (1,1) {mustBeInteger, mustBeGreaterThan(n, 0)} = 1
end

for i = 1:n
    tic
    vdptest()
    t = toc;
end
end

function vdptest()
for tf = [100, 1000, 5000, 25000]
   ode45(@vdp1, [0, tf], [0, 2]) 
end
end

