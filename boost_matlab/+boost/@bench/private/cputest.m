function cputest()
for n = 1000:1000:10000
    a = rand(n);
    b = rand(n);
    c = a*b;
    d = a\b;
    e = sin(c);
    f = exp(d);
    g = fft(f); 
end
end

%#ok<*NASGU>