@echo off

echo Current State:
sc query "Symantec AntiVirus" | find "STATE"

echo Starting AV..
sc start "Symantec AntiVirus" | find "STATE"

:CHECKLOOP
  :: Use PING time-outs to create the delay
  PING 1.1.1.1 -n 1 -w 1000 2>NUL | FIND "TTL=" >NUL

  sc query "Symantec AntiVirus" | find "STATE" | find "RUNNING" > tmp
  SET /P STARTEDMSG=< tmp
  del tmp

  IF "%STARTEDMSG%" == "" GOTO CHECKLOOP

:END
  echo %STARTEDMSG%
  echo Sucessfully started
  pause
