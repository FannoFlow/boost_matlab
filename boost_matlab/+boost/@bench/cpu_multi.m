function t = cpu_multi()
%BENCHCPU run a multi-threaded cpu benchmark 
% code is derived from
% https://github.com/FannoFlow/mat_test/blob/master/mat_test.m
%
% WATCH YOUR CPU THERMALS
% This benchmark is extreemly heavy in AVX instructions, and will cause
% your CPU to hit thermals limits quickly if not adequetly cooled!

x = maxNumCompThreads('automatic');

tic
cputest()
t = toc;

maxNumCompThreads(x);
end