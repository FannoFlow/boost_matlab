function tt = timeseries2timetable(ts, NameValueArgs)
%TIMESERIES2TIMETABLE Construct a timetable from a set of timeseries
%objects.
%
% tt = timeseries2timetable(ts)
%   Constructs a timetable object, tt, from a timeseries object, ts.
%
% tt = timeseries2timetable(ts1, ts2, ..., tsN)
%   Constructs a timetable object, tt, from N number of timeseries objects, tsN.
%
% tt = timeseries2timetable(__,Name,Value)
%   Constructs a timetable, tt, object using any number of Name,Value argument pairs. 


arguments (Repeating)
    ts (1,1) timeseries
end
arguments 
    NameValueArgs.VariableNames (1,:) string {...
        boost.validation.mustHaveSameNumberOfElements(NameValueArgs.VariableNames, ts, "VariableNames", "ts") ...
        } = repmat("",1,numel(ts))
end

tt = cellfun(@ts2ttHelper, ts, "UniformOutput",false);
tt = synchronize(tt{:});

if ~all(NameValueArgs.VariableNames == "")
    tt.Properties.VariableNames = NameValueArgs.VariableNames;
end
end

function tt = ts2ttHelper(ts)
% durations need h,m,s,ms

switch ts.TimeInfo.Units
    case "weeks" 
        timefactor = 7*24*60*60;
    case "days" 
        timefactor = 24*60*60;
    case "hours"
        timefactor = 60*60;
    case "minutes"
        timefactor = 60;
    case "seconds" 
        timefactor = 1;
    case "milliseconds"
        timefactor = 1e-3;
    case "microseconds" 
        timefactor = 1e-6;
    case "nanoseconds"
        timefactor = 1e-9;
end
tt = constructTimeTableFromNumericTimeVector(ts.Time, ts.Data, timefactor);
if ts.Name ~= ""
    tt.Properties.VariableNames = {ts.Name};
end
end