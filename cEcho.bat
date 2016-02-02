```
@echo off
setlocal EnableDelayedExpansion
if "%~1" == "-help" goto :help

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

:: remove variables starting $ or #
For %%b IN ($ #) DO FOR  /F "delims==" %%a In ('set %%b 2^>Nul') DO SET "%%a="

SET /a count=0
SET "select=this is select's original value"

:loop
REM SET $... and #... to the parameter-pair.
SET $%count%=%1
SET #%count%=%2
IF NOT DEFINED $%count% GOTO process
IF NOT DEFINED #%count% ECHO "Incomplete pair"&GOTO :EOF
SET /a count +=1
:: shift twice to move 2 parameters
shift&shift&GOTO loop

:process

FOR /L %%a IN (1,1,%count%) DO (
 REM note that this changes "select"
 SET /a select=%%a - 1
 CALL SET item1=%%$!select!%%
 CALL SET item2=%%#!select!%%
 call :color !item2! !item1!
)
exit /b

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b

:help
if "%~2" == "-s" goto :helpsyntax
if "%~2" == "-a" goto :helppair
if "%~2" == "-c" goto :helpreference
call %0 "c" 0E "Echo" 08 " is used for colorizing text" 07
echo(
echo *it requires an even numbered amount of arguments to run correctly
echo(
call %0 "c" 0E "Echo" 08  " references:" 07
echo(
call %0 "c" 0E "Echo" 08 " -help [argument]  :  [function]" 07
echo(
echo                    -s   :  syntax
echo                    -a   :  argument pair syntax
echo                    -c   :  color reference
exit /b

:helpsyntax
call %0 "c" 0E "Echo" 08 " syntax is: " 07 "c" 0E "Echo" 08 " [argument_pair1[ argument_pair2[ ...]]]" 07
echo(
call %0 "look at " 07 "c" 0E "Echo" 08  " -help -a for argument pair syntax" 07
exit /b
:helppair
echo argument pairs use syntax [text_to_colorize] [color_code]
call %0 "look at " 07 "c" 0E "Echo" 08  " -help -c for color code reference" 07
exit /b
:helpreference
echo color codes have 2 characters: 1 for the background ($) and 1 for the text (#).
echo the syntax is simple: $#
echo here is a table of all available color codes
echo color  :  normal_code  : bright_code
call %0 "Black  :  " 07 "0" 70 "            :  " 07 "8" 08
echo(
call %0 "Blue   :  " 07 "1" 71 "            :  " 07 "9" 09
echo(
call %0 "Green  :  " 07 "2" 72 "            :  " 07 "A" 0A
echo(
call %0 "Aqua   :  " 07 "3" 73 "            :  " 07 "B" 0B
echo(
call %0 "Red    :  " 07 "4" 74 "            :  " 07 "C" 0C
echo(
call %0 "Purple :  " 07 "5" 75 "            :  " 07 "D" 0D
echo(
call %0 "Yellow :  " 07 "6" 76 "            :  " 07 "E" 0E
echo(
call %0 "White  :  " 07 "7" 07 "            :  " 07 "F" 0F
exit /b
```
