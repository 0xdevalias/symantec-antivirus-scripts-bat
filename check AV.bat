@echo off

sc query "Symantec AntiVirus" | find "STATE"

pause