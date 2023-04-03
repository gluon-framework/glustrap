rmdir /s /Q bin
mkdir bin

nim -d:release --gc:none --opt:size --app:gui -o:bin\win_x64.exe c main.nim
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\win_x86.exe c main.nim -t windows-i386
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\win_arm64.exe c main.nim -t windows-arm64

call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\linux_x64 c main.nim -t linux-amd64
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\linux_x86 c main.nim -t linux-i386
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\linux_arm64 c main.nim -t linux-arm64

call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\mac_x64 c main.nim -t macosx-amd64
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin\mac_arm64 c main.nim -t macosx-arm64

strip -s bin\*