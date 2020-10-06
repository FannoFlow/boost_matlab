function t = table(name)
%BENCHTABLE returns the current bench table in boost

arguments
   name (1,1) string {mustBeMember(name, ...
       ["cpu_single", "cpu_multi", "vdp"])} = "cpu_multi" 
end

f = split(string(fullfile(mfilename('fullpath'))), filesep)';
f(end) = [];
f = join(f, filesep);
t = readtable(fullfile(f, "private", name + ".csv"));

end

