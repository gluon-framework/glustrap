#!/bin/sh

mkdir bin

# linux x64 (native)
nim -d:release --gc:none --opt:size --app:gui -o:bin/linux_x64 c main.nim

# linux x86 (cross)
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/linux_x86 c main.nim -t linux-i386

# linux arm64 (cross)
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/linux_arm64 c main.nim -t linux-arm64

# strip all bins
strip -s bin/linux_x64 bin/linux_x86
aarch64-linux-gnu-strip -s bin/linux_arm64