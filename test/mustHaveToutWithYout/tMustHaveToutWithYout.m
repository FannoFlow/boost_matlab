classdef tMustHaveToutWithYout < matlab.unittest.TestCase
    %TMUSTHAVETOUTWITHYOUT verify validation behavior of tout and yout
    
    methods (Test)
        function verifyToutAndYout(testCase)
            s = Simulink.SimulationOutput;
            s.a = [];
            testCase.verifyError(@() boost.validation.mustHaveToutWithYout(s, "b", "a"), "boost:validation:mustHaveToutWithYout")
            testCase.verifyWarningFree(@() boost.validation.mustHaveToutWithYout(s, "a", "b"))
            s.b = [];
            testCase.verifyWarningFree(@() boost.validation.mustHaveToutWithYout(s, "a", "b"))
            testCase.verifyWarningFree(@() boost.validation.mustHaveToutWithYout(s, "b", "a"))
        end
    end
end

