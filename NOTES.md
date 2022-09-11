# Organizational parallelism caveats
- modules for headers
  - except for changing Rect to Geometry to avoid collision with Rect struct
- files for module structs/unions/enums
  - except for some shared enums - add directly to sdl
- no changes to names other than...
  - SDL_ prefixes removed
  - case based on ruby-side norms to avoid surprise
  - additional underscores for readability
  - keycode symbols because they're bad

# On keyboard button representation
- keycode and scancode are both helpful
  - scancode for positional controls (WASD for movement)
  - keycode for "named" controls (I to open inventory)
- names are not helpful because they are not stable when scancode != keycode (e.g. DVORAK)
  - name -> scancode
  - name -> keycode -> scancode
- normalizing (scancode, keycode, name) pairing will make name more helpful
- we choose to normalize pairing as (scancode, keycode, name(keycode))

#  Windows install
- install chocolately
- install ruby via chocolatey
  - `choco install ruby --version=[VERSION] --side-by-side`
  - side-by-side installation allows ridk to manage multiple ruby versions
- install msys2 via chocolatey
  - `choco install msys2 --params "/NoUpdate"`
- restart session to include e.g. env changes
- finish msys2 install using ridk
  - `ridk install 2 3`
- install tools for native compilation
  - `ridk exec pacman -S --needed base-devel mingw-w64-x86_64-toolchain`
- bundle install, etc
