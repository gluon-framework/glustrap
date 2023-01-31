import os
import osproc
import strutils

import winim/mean
if AttachConsole(-1).bool: # fix stdout in already opened cmd when compiling as a gui app
  discard stdout.reopen("CONOUT$", fmWrite)

let nodeDir = getEnv("localappdata") / "gluon" / "node"

# always include our local user nodejs path
putEnv("PATH", getEnv("PATH") & ";" & nodeDir)

var installedNodeMajor = 0
try:
  installedNodeMajor = parseInt(execCmdEx("node -v", options={ poUsePath, poStdErrToStdOut, poDaemon })[0].split(".")[0].substr(1))
except:
  discard

echo "glustrap: installed nodejs major version: " & intToStr(installedNodeMajor)

if installedNodeMajor < 16:
  echo "glustrap: installing own nodejs as failed to find good already installed version..."

  let nodeTemp = getEnv("temp") / "node.zip"
  let nodeVersion = "18.13.0"

  let nodeDownloadUrl = "https://nodejs.org/dist/v" & nodeVersion & "/node-v" & nodeVersion & "-win-x64.zip"

  createDir(nodeDir)

  echo "glustrap: downloading node..."
  discard execCmdEx("curl.exe -s \"" & nodeDownloadUrl & "\" -o \"" & nodeTemp & "\"", options={ poUsePath, poStdErrToStdOut, poDaemon })

  echo "glustrap: extracting node..."
  discard execCmdEx("tar.exe -xf \"" & nodeTemp & "\" -C \"" & nodeDir & "\" --strip-components=1", options={ poUsePath, poStdErrToStdOut, poDaemon })

  removeFile(nodeTemp)

echo "glustrap: starting node...\n"

let targetDir = getAppDir() / "app"
let nodeArgs = "." & commandLineParams()

let process = startProcess("node", workingDir=targetDir, args=nodeArgs, options={ poUsePath, poParentStreams })
discard process.waitForExit()