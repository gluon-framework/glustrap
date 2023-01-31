import os
import osproc
import strutils

when defined windows:
  import winim/mean
  if AttachConsole(-1).bool: # fix stdout in already opened cmd when compiling as a gui app
    discard stdout.reopen("CONOUT$", fmWrite)

var nodeDir = ""
when defined(windows):
  nodeDir = getEnv("localappdata") / "gluon" / "node"
else:
  nodeDir = getConfigDir() / "gluon" / "node"

# always include our local user nodejs path
putEnv("PATH", getEnv("PATH") & PathSep & nodeDir & PathSep & nodeDir / "bin")

var installedNodeMajor = 0
try:
  installedNodeMajor = parseInt(execCmdEx("node -v", options={ poUsePath, poStdErrToStdOut, poDaemon })[0].split(".")[0].substr(1))
except:
  discard

echo "glustrap: installed nodejs major version: " & intToStr(installedNodeMajor)

if installedNodeMajor < 16:
  echo "glustrap: installing own nodejs as failed to find good already installed version..."

  var ext = ""
  when defined(windows): # windows builds use zip, others use tar.gz
    ext = ".zip"
  else:
    ext = ".tar.gz"

  let nodeTemp = getTempDir() / "node" & ext
  let nodeVersion = "18.13.0"

  var nodeDownloadUrl = "https://nodejs.org/dist/v" & nodeVersion & "/node-v" & nodeVersion

  when defined(windows):
    nodeDownloadUrl &= "-win"
  elif defined(linux):
    nodeDownloadUrl &= "-linux"
  elif defined(macosx):
    nodeDownloadUrl &= "-darwin"

  when defined(amd64): # x86 64 bit
    nodeDownloadUrl &= "-x64"
  elif defined(i386): # x86 32 bit
    nodeDownloadUrl &= "-x86"
  elif defined(arm64): # arm 64 bit
    nodeDownloadUrl &= "-arm64"
  elif defined(arm): # arm 32 bit (?) - linux only
    nodeDownloadUrl &= "-armv7l"

  nodeDownloadUrl &= ext

  when defined(windows) and defined(arm64): # nodejs windows on arm is unofficial currently
    nodeDownloadUrl = "https://unofficial-builds.nodejs.org/download/release/v19.3.0/node-v19.3.0-win-arm64.zip"

  echo nodeDownloadUrl

  createDir(nodeDir)

  echo "glustrap: downloading node..."
  discard execCmdEx("curl -s \"" & nodeDownloadUrl & "\" -o \"" & nodeTemp & "\"", options={ poUsePath, poStdErrToStdOut, poDaemon })

  echo "glustrap: extracting node..."
  discard execCmdEx("tar -xf \"" & nodeTemp & "\" -C \"" & nodeDir & "\" --strip-components=1", options={ poUsePath, poStdErrToStdOut, poDaemon })

  removeFile(nodeTemp)

echo "glustrap: starting node...\n"

let targetDir = getAppDir() / "app"
let nodeArgs = "." & commandLineParams()

let process = startProcess("node", workingDir=targetDir, args=nodeArgs, options={ poUsePath, poParentStreams })
discard process.waitForExit()