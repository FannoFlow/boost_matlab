function mustBePC()
%MUSTBEPC Validates that the host is a PC

if ~ispc()
    error("boost:mustBePC", "System must be a Windows PC")
end

end

