function t = cpu_single()
%CPU_SINGLE run a single-threaded cpu benchmark 
% code is derived from
% https://github.com/FannoFlow/mat_test/blob/master/mat_test.m

x = maxNumCompThreads(1);

tic
cputest()
t = toc;

maxNumCompThreads(x);
end

