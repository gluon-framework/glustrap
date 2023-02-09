#!/bin/sh

mkdir bin

# mac x64 (native)
nim -d:release --gc:none --opt:size --app:gui -o:bin/mac_x64 c main.nim

# mac arm64 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/mac_arm64 c main.nim -t macosx-arm64

# strip all bins
strip -s bin/*