classdef tBadInputs < matlab.unittest.TestCase
    %TBADINPUTS error behavior of timeseries2timetable
    
    properties (TestParameter)
        BadTT = {
            {'a', 'b'};
            }
        
        ExpectedSimOutError = {
            'MATLAB:validation:UnableToConvert';
            }
        
        BadVariableNames = {
            ["a", "b"];
            griddedInterpolant;
            }
        ExpectedVariableNamesError = {
            'boost:validation:mustHaveSameNumberOfElements';
            'MATLAB:validation:UnableToConvert';
            }
    end
    
    methods (Test, ParameterCombination='sequential')
        function verifySimOut(testCase, BadTT, ExpectedSimOutError)
            testCase.verifyError(@() timeseries2timetable(BadTT), ExpectedSimOutError)
        end
        function verifyVariableNames(testCase, BadVariableNames, ExpectedVariableNamesError)
            testCase.verifyError(@() timeseries2timetable(1, "Variablenames", BadVariableNames), ExpectedVariableNamesError)
        end
    end
end