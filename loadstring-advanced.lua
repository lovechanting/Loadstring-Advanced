local LoadstringLib = {}

local HttpService = game:GetService("HttpService")

function LoadstringLib.Execute(url, args)
    assert(type(url) == "string", "URL must be a string")
    assert(type(args) == "table" or args == nil, "Arguments must be in a table or nil")
    
    local success, scriptSource = pcall(function()
        return HttpService:GetAsync(url)
    end)
    
    if not success then
        error("Failed to fetch script from URL")
    end
    
    local env = setmetatable({}, { __index = getfenv() })
    if args then
        for k, v in pairs(args) do
            env[k] = v
        end
    end
    
    local scriptFunction, err = loadstring(scriptSource)
    if not scriptFunction then
        error("Failed to compile script: " .. err)
    end
    
    setfenv(scriptFunction, env)
    return scriptFunction()
end

return LoadstringLib
