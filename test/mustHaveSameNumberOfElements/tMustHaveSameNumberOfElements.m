classdef tMustHaveSameNumberOfElements < matlab.unittest.TestCase
    %TMUSTHAVESAMENUMBEROFELEMENTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        input1 = {
            rand(6);
            1;
            [NaN, NaN]
            }
        input2 = {
            rand(6);
            1;
            ["a"; "b"]
            }
        
    end
    
    methods (Test)
        function verifySameNumberOfElements(testCase, input1, input2)
            if numel(input1) ~= numel(input2)
                testCase.verifyError(@() boost.validation.mustHaveSameNumberOfElements(input1, input2, "in1", "in2"), "boost:validation:mustHaveSameNumberOfElements");
            else
                testCase.verifyWarningFree(@() boost.validation.mustHaveSameNumberOfElements(input1, input2, "in1", "in2"))
            end
        end
    end
end

