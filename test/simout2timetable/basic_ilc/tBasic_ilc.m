classdef tBasic_ilc < matlab.unittest.TestCase
    
    properties
        Model = "mBasic_ilc"
    end
    
    methods (TestMethodSetup)
        function loadmodel(testCase)
            load_system(testCase.Model)
        end
    end
    
    methods
        function closemodel(testCase)
            evalin("base", "clear sys_dt T_end Ts")
            close_system(testCase.Model, 0)
        end
    end
    
    methods (Test)
        function verifyErrorFreeConstruction(testCase)
            %% System
            m = 5; %kg
            Ts = 0.1e-3; % 0.1 ms
            s = tf('s');
            sys_ct = 1/(m*s^2);
            sys_dt = c2d(sys_ct,Ts);
            assignin("base", "sys_dt", sys_dt)
            
            %% Controller
            %z = tf('z',Ts);
            Kp = 571;
            Kd = 51.1;
            %C = Kp+Kd*(z-1)/Ts;
            
            set_param(testCase.Model + "/" + "Gain", "Gain", string(m))
            set_param(testCase.Model + "/" + "PID Controller", "P", string(Kp))
            set_param(testCase.Model + "/" + "PID Controller", "D", string(Kd))
            
            %% Simulation
            T_end = 1;
            assignin("base", "T_end", T_end)
            assignin("base", "Ts", Ts)
            
            t = 0:Ts:T_end;
            [ref, vel, acc, ~] = quinticpolytraj([0 0.1 0.1 0],[0 0.25*T_end 0.75*T_end T_end], t);
            % plot(t,ref,t,vel,t,acc)
            in = Simulink.SimulationInput(testCase.Model);
            in = in.setExternalInput([t',ref',vel',acc']);
            simout = sim(in);
            testCase.verifyWarningFree(@() simout2timetable(simout));
        end
    end
end