#!/bin/sh

mkdir bin

# linux x64 (native)
nim -d:release --gc:none --opt:size --app:gui -o:bin/linux_x64 c main.nim

# linux x86 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/linux_x86 c main.nim -t linux-i386

# strip all bins
strip -s bin/*