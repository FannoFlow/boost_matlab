function dbstopOnComplex(val)
% DBSTOPONCOMPLEX stop execution when a complex value is encountered
%
% If a complex value is encountered in any of the input arguments, a
% breakpoint is set on the "stopExecution" line. The input variables that
% are complex will be indicated by the 'complexVars' variable.
% If no inputs are complex, no breakpoint is set.
%
% Inputs:
%   val  :Reapeating number of numeric input arguments.
%
% Example:
%
%  a = 1;
%  b = 1i;
%  dbStopOnComplex(a,b)

% Copyright 2020 David Coventry

arguments (Repeating)
    val {mustBeNumeric}
end
complexidx = ~cellfun(@isreal, val);
if any(complexidx)
    complexValues = val(complexidx);
    complexVars = string(arrayfun(@inputname, find(complexidx), "UniformOutput", false));
    dbstop in dbstopOnComplex at 32
else
    dbclear all in dbstopOnComplex
end

stopExecution = 1; 
%#ok<*NASGU>
end
