@ECHO OFF
:: Enter any argument to recompile
IF "%1"=="" GOTO Run ELSE
:: Recompile main
asm6 main.asm Lumber.nes
echo =============
echo Recompiled...
:Run
echo =============
echo Running...
FCEUX Lumber.nes
echo =============
echo Exited...
echo =============
