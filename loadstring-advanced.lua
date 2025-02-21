local LoadstringLib = {}

function LoadstringLib.Execute(scriptSource, args)
    assert(type(scriptSource) == "string", "Script source must be a string")
    assert(type(args) == "table" or args == nil, "Arguments must be in a table or nil")

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
