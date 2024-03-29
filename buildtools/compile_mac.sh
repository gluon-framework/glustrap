#!/bin/sh

mkdir bin

# mac x64 (native)
nim -d:release --passL:-s --passC:-flto --passL:-flto --gc:none --opt:size --app:gui -o:bin/mac_x64 c main.nim

# mac arm64 (cross)
nimxc -d:release --passL:-s --gc:none --opt:size --app:gui -o:bin/mac_arm64 c main.nim -t macosx-arm64

# strip all bins
strip bin/mac_x64
# strip bin/mac_arm64