mkdir bin

rem win x64 (native)
nim -d:release --gc:none --opt:size --app:gui -o:bin/win_x64.exe c main.nim

rem win x86 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_x86.exe c main.nim -t windows-i386

rem win arm64 (cross)
call nimxc -d:release --gc:none --opt:size --app:gui -o:bin/win_arm64.exe c main.nim -t windows-arm64

rem strip all bins
strip -s bin/*.exe