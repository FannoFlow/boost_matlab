function tt = constructTimeTableFromDataset(data)
%CONSTRUCTTIMETABLEFROMDATASET internal method for constructing a timetable
%from a Simulink dataset

arguments
    data Simulink.SimulationData.Dataset
end

tt = arrayfun(@(n) sig2tt(data{n}),1:data.numElements, "UniformOutput",false);

end

function tt = sig2tt(sig)
tt = constructTimeTableFromNumericTimeVector(sig.Values.Time,sig.Values.Data);
if sig.Name == "" % unammed signal
    % extract the name from the signal port and index
    tt.Properties.VariableNames = {sig.PortType + "_" + sig.PortIndex};
else
    tt.Properties.VariableNames = {sig.Name};
end
end


