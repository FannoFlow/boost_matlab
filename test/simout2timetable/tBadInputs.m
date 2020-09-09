classdef tBadInputs < matlab.unittest.TestCase
    %TBADINPUTS error behavior of simout2timetable
    
    properties (TestParameter)
        BadSimOut = {
            1;
            NaN;
            "hello";
            }
        
        ExpectedSimOutError = {
            'MATLAB:validation:UnableToConvert';
            'MATLAB:validation:UnableToConvert';
            'MATLAB:validation:UnableToConvert';
            }
    end
    
    methods (Test, ParameterCombination='sequential')
        function verifySimOut(testCase, BadSimOut, ExpectedSimOutError)
            testCase.verifyError(@() simout2timetable(BadSimOut), ExpectedSimOutError)
        end
    end
end

