if not SF.Require("effil") then return function() end end
SF.RegisterLibrary("effil")

-- # Custom Permission & Provider

-- If using whitelist option, add player's SteamID64 below.
-- Example:
--[[
local whitelist = { 
    "76561197960279927", -- garry
    "76561197960279929", -- some random guy
}
]]
local whitelist = {}

SF.Permissions.registerPrivilege("effil.thread", "Create new threads", "Allows the user to create new threads")
SF.Permissions.registerPrivilege("effil.table", "Create new effil.table", "Allows the user to create new shared tables")
SF.Permissions.registerPrivilege("effil.channel", "Create new effil.channel", "Allow the user to create new channels")
SF.Permissions.registerPrivilege("effil.gc", "Access effil.gc functions", "Allow the user to access effil.gc functions")

-- Convert array into map for reduced lookup time
local whitelist_map = {}

for _, id in pairs(whitelist) do
    whitelist_map[id] = true
end

-- Implement provider interface
local provider = {}
provider.id = "effil_perm"
provider.name = "Effil Permissions"
provider.settingsoptions = {"Anyone", "No one", "Admin", "Whitelist"}
provider.defaultsetting = 4
provider.checks = {
    "allow",
    "block",
    function(instance, target, key)
        return instance.player:IsAdmin(), "This function is admin only"
    end,
    function(instance, target, key)
        return whitelist_map[instance.player:SteamID64()] == true, "This function is whitelisted account only"
    end
}

SF.Permissions.registerCustomProvider(provider, {"effil.thread", "effil.table", "effil.channel", "effil.gc"}, true)

-- # Library Instance Creation
return function(instance)
    local effil_library = instance.Libraries.effil

    -- Thread functions
    effil_library.thread = function(...)
        SF.Permissions.check(instance, nil, "effil.thread")

        return effil.thread(...)
    end

    effil_library.thread_id = function(...)
        SF.Permissions.check(instance, nil, "effil.thread")

        return effil.thread_id(...)
    end

    effil_library.yield = function(...)
        SF.Permissions.check(instance, nil, "effil.thread")

        return effil.yield(...)
    end

    effil_library.sleep = function(...)
        SF.Permissions.check(instance, nil, "effil.thread")

        return effil.sleep(...)
    end

    effil_library.hardware_threads = function(...)
        SF.Permissions.check(instance, nil, "effil.thread")

        return effil.hardware_threads(...)
    end

    -- Shared table functions
    effil_library.table = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.table(...)
    end

    effil_library.setmetatable = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.setmetatable(...)
    end

    effil_library.getmetatable = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.getmetatable(...)
    end

    effil_library.rawset = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.rawset(...)
    end

    effil_library.rawget = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.rawget(...)
    end

    -- TODO: find ways to directly expose table
    effil_library.getglobal = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.G
    end

    effil_library.dump = function(...)
        SF.Permissions.check(instance, nil, "effil.table")

        return effil.dump(...)
    end

    -- Channel functions
    effil_library.channel = function(...)
        SF.Permissions.check(instance, nil, "effil.channel")

        return effil.channel(...)
    end

    -- GC functions
    effil_library.gc = {}

    effil_library.gc.collect = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.collect(...)
    end

    effil_library.gc.count = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.count(...)
    end

    effil_library.gc.step = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.step(...)
    end

    effil_library.gc.pause = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.pause(...)
    end

    effil_library.gc.resume = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.resume(...)
    end

    effil_library.gc.enabled = function(...)
        SF.Permissions.check(instance, nil, "effil.gc")

        return effil.gc.enabled(...)
    end

    -- Other functions
    effil_library.size = effil.size
    effil_library.type = effil.type
end