function tt = constructTimeTableFromNumericTimeVector(time, data, timefactor)
% internal method for constructing a time table from time data (seconds)
% and the accompanying data values

arguments
    time {mustBeNumeric}
    data
    timefactor (1,1) {mustBeReal, mustBeFinite} = 1;
end

time = time * timefactor;

h = floor(mod(time/3600,3600)); %hours
m = floor(mod(time/60,60)); % minutes
s = floor(mod(time, 60)); % seconds
ms = mod(time,1)*1000; % miliseconds

Time = duration(h,m,s,ms);
tt = timetable(Time, data);
end