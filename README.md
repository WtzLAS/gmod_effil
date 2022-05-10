# gmod_effil

Multithreading library for gmod and starfall using [effil](https://github.com/effil/effil).

It may have better performance than `lanes`.

## Installation

Prebuilt binaries can be found in tab `Actions` above.

Put dll files into `garrysmod/lua/bin` and you are good to go.

To enable starfall support, put `starfall/effil.lua` into `garrysmod/lua/addons/StarfallEx/lua/starfall/libs_sh`.

## Example

```lua
require("effil")

local f = effil.thread(function(n) return n * 2 end)

local handle = f(15)
local handle2 = f(30)

print(handle:get(), handle2:get())
```

Effil documentation can be found in [here](https://github.com/effil/effil#api-reference).

## Build

### Prerequisites

`premake5` and an available build tool (such as `Visual Studio 2022` or `gcc` with `make`).

### Steps

1. Clone the repository and the submodules recursively.

2. Apply the patch `0001-fix-luaL_loadbufferx-redefinition.patch` to `effil/libs/sol`.

3. Run `premake5` to configure.

4. Build.

## Starfall Permissions

Default settings are whitelisted users only.

See `starfall/effil.lua` for more information.
