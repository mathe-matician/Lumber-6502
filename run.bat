@ECHO OFF
:: Recompile main
asm6 main.asm Lumber.nes
echo =============
echo Recompiled...
echo =============
echo Running...
FCEUX Lumber.nes
echo =============
echo Exited...
echo =============
