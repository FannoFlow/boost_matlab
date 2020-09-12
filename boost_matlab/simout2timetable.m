function tt = simout2timetable(simout, NameValueArgs)
% SIMOUT2TIMETABLE Construct a timetable from a Simulink.SimulationOutput
% object.
%
% TT = SIMOUT2TIMETABLE( SIMOUT ) 
%
% Converts a Simulink.SimulationOutput object, SIMOUT to a timetable, TT.
%
% Examples:
%
% simout = sim('vdp',"SaveOutput","on","SaveTime","on","ReturnWorkspaceOutputs",true)
% tt = simout2timetable(simout)


arguments
    simout (1,1) Simulink.SimulationOutput
    NameValueArgs.TimeSaveName (1,1) string = "tout"
    NameValueArgs.OutputSaveName (1,1) string = "yout"
    NameValueArgs.StateSaveName (1,1) string = "xout"
    NameValueArgs.FinalStateName (1,1) string = "xout"
    NameValueArgs.SignalLoggingName (1,1) string = "logsout"
    NameValueArgs.DSMLoggingName (1,1) string = "dsmout"
    NameValueArgs.RetrieveFromModel (1,1) matlab.lang.OnOffSwitchState = false
end

% if the model was input, retrieve the model params through get_param
if NameValueArgs.RetrieveFromModel 
    fields = string(fieldnames(NameValueArgs));
    fields = fields(1:6);
    for i = 1:numel(fields)
        f = fields(i);
        NameValueArgs.(f) = string(get_param(simout.SimulationMetadata.ModelInfo.ModelName, f));
    end
end

% initialization
simvars = simout.who;
timetables = {};

% post-arguments validation
boost.validation.mustHaveToutWithYout(simout, NameValueArgs.TimeSaveName, NameValueArgs.OutputSaveName);

if any(simvars == NameValueArgs.OutputSaveName)
    outputTT = constructTimeTable(simout.(NameValueArgs.TimeSaveName), simout.(NameValueArgs.OutputSaveName));
    timetables = appendTimeTable(timetables, outputTT);
end

if any(simvars == NameValueArgs.SignalLoggingName)
    sigsTT = constructTimeTableFromDataset(simout.(NameValueArgs.SignalLoggingName));
    timetables = appendTimeTable(timetables, sigsTT);
end

% final step, synchronize all of the timetables
if ~isempty(timetables)
    tt = synchronize(timetables{:});
else
    tt = timetable;
end
end

function timetables = appendTimeTable(timetables, newtables)
if iscell(newtables)
    timetables = [timetables, newtables];
else
    timetables = [timetables, {newtables}];
end
end


