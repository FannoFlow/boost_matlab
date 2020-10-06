classdef bench
    %BENCH run a boost benchmark
    
    properties (Constant)
        Version = "1";
    end
    
    properties (SetAccess = private)
        Name
        Clock
        Cache
        NumProcessors
        OSType
        OSVersion
        Benchmark
        Runs
        Time
    end
    properties (Dependent)
        Score
    end
    
    methods
        function obj = bench(n, NameValues)
            %BENCH Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                n (1,1) {mustBeInteger, mustBeGreaterThan(n, 0)} = 1
                NameValues.Benchmark (1,1) string {mustBeMember(NameValues.Benchmark, ...
                    ["Single", "Multi", "VDP"])} = "Multi";
            end
            
            info = boost.bench.cpuinfo();
            obj.Name = info.Name;
            obj.Clock = info.Clock;
            obj.Cache = info.Cache;
            obj.NumProcessors = info.NumProcessors;
            obj.OSType = info.OSType;
            obj.OSVersion = info.OSVersion;
            obj.Benchmark = NameValues.Benchmark;
            obj.Runs = n;
            obj.Time = ones(1,n)*inf;
            
            switch NameValues.Benchmark
                case "Single"
                    benchfun = @boost.bench.cpu_single;
                case "Multi"
                    benchfun = @boost.bench.cpu_multi;
                case "VDP"
                    benchfun = @boost.bench.vdp;
            end
            
            for i = 1:n
                obj.Time(i) = benchfun();
            end
        end
    end
    
    methods (Static)
        t = table(name)
        info = cpuinfo()
        t = cpu_single()
        t = cpu_multi()
        t = vdp(n)
    end
    
    methods
        function s = get.Score(obj)
            s = round(((1000./obj.Time)) .* 100);
        end
    end
end

