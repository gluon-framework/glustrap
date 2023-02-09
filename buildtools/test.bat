nim -d:release --gc:none --opt:size --app:gui -o:gluon_bootstrap.exe c main.nim
rem nim --gc:none --opt:size --app:gui -o:gluon_bootstrap.exe c main.nim

strip -s gluon_bootstrap.exe

.\gluon_bootstrap.exe