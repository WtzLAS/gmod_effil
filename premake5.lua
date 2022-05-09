local gmcommon = "./garrysmod_common"
include(path.join(gmcommon, "generator.v3.lua"))

local effil_directory = "./effil/src/cpp"
local sol_directory = "./effil/libs/sol/single/sol"

CreateWorkspace({name = "effil"})
	CreateProject({serverside = true})
		includedirs({effil_directory, sol_directory})
		links("effil")
		IncludeLuaShared()
		filter("system:linux")
			buildoptions("-pthread -ldl")
			linkoptions("-pthread -ldl")

	CreateProject({serverside = false})
		includedirs({effil_directory, sol_directory})
		links("effil")
		IncludeLuaShared()
		filter("system:linux")
			buildoptions("-pthread -ldl")
			linkoptions("-pthread -ldl")

	project("effil")
		kind("StaticLib")
		warnings("Default")
		includedirs({effil_directory, path.join(gmcommon, "include"), sol_directory})
		files({path.join(effil_directory, "*.cpp"), path.join(effil_directory, "*.h")})
		vpaths({
			["Source files/*"] = path.join(effil_directory, "*.cpp"),
			["Header files/*"] = path.join(effil_directory, "*.h")
		})
		IncludeLuaShared()
		filter("system:linux")
			buildoptions("-pthread -ldl")
			linkoptions("-pthread -ldl")