function mustHaveSameNumberOfElements(var1,var2,var1Name,var2Name)
%MUSTHAVESAMENUMBEROFELEMENTS validation function for matching the same
%number of elements of var1 and var2.

arguments
    var1
    var2
    var1Name (1,1) string
    var2Name (1,1) string
end

if numel(var1) ~= numel(var2)
    error("boost:validation:mustHaveSameNumberOfElements",...
        "'%s' must have the same number of elements as '%s'.", var1Name, var2Name)

end
end

