@echo off

echo Current State:
sc query "Symantec AntiVirus" | find "STATE"

echo Stopping AV..
sc stop "Symantec AntiVirus" | find "STATE"

:CHECKLOOP
  :: Use PING time-outs to create the delay
  PING 1.1.1.1 -n 1 -w 1000 2>NUL | FIND "TTL=" >NUL

  sc query "Symantec AntiVirus" | find "STATE" | find "STOPPED" > tmp
  SET /P STOPPEDMSG=< tmp
  del tmp

  IF "%STOPPEDMSG%" == "" GOTO CHECKLOOP

:END
  echo %STOPPEDMSG%
  echo Sucessfully stopped
  pause
