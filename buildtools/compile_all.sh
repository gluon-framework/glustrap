#!/bin/sh

mkdir bin
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_x64.exe c main.nim -t windows-amd64
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_x86.exe c main.nim -t windows-i386
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_arm64.exe c main.nim -t windows-arm64

nimxc -d:release --gc:none --opt:size --app:gui -o:bin/linux_x64 c main.nim -t linux-amd64
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/linux_x86 c main.nim -t linux-i386

nimxc -d:release --gc:none --opt:size --app:gui -o:bin/mac_x64 c main.nim -t macosx-amd64
nimxc -d:release --gc:none --opt:size --app:gui -o:bin/mac_arm64 c main.nim -t macosx-arm64

strip -s bin/*