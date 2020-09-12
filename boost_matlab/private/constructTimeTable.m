function tt= constructTimeTable(time,data)
%CONSTRUCTTIMETABLE internal method for dispatching timetable construction

arguments
   time {mustBeNumeric}
   data
end

if isa(data, "Simulink.SimulationData.Dataset")
    tt = constructTimeTableFromDataset(data);
else
    tt = constructTimeTableFromNumericTimeVector(time, data);
end

end

