#!/bin/sh

nim -d:release --gc:none --opt:size --app:gui -o:gluon_bootstrap c main.nim
# nim --gc:none --opt:size --app:gui -o:gluon_bootstrap c main.nim

strip -s gluon_bootstrap

./gluon_bootstrap