#include <GarrysMod/Lua/Interface.h>
#include <utils.h>

GMOD_MODULE_OPEN()
{
    if (luaopen_effil(LUA->GetState()) == 1)
    {
        LUA->SetField(GarrysMod::Lua::INDEX_GLOBAL, "effil");
    }
    return 0;
}

GMOD_MODULE_CLOSE()
{
    LUA->PushNil();
    LUA->SetField(GarrysMod::Lua::INDEX_GLOBAL, "effil");
    return 0;
}
