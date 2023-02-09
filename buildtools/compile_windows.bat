mkdir bin

# win x64 (native)
nim -d:release --gc:none --opt:size --app:gui -o:bin/win_x64.exe c main.nim

# win x86 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_x86.exe c main.nim -t windows-i386

# win arm64 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_arm64.exe c main.nim -t windows-arm64

# strip all bins
strip -s bin/*