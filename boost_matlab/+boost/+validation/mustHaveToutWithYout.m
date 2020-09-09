function mustHaveToutWithYout(simout, toutName, youtName)
%MUSTHAVETOUTWITHYOUT validation method for testing if simout struct has a
%tout variable with a yout variable

arguments
    simout (1,1) Simulink.SimulationOutput
    toutName (1,1) string
    youtName (1,1) string
end

varnames = simout.who;
if any(varnames == youtName) && ~any(varnames == toutName)
    error("boost:validation:mustHaveToutWithYout",...
        join(["The output variable, '%s' exists, but time variable, '%s', does not.";
        "Run the simulation again with 'SaveTime', 'on'"],"\n"),youtName,toutName)
end 
end

