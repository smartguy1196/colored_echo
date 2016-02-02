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
call %0 "c" 0E "Echo" 08 " is used for " 07 "colorizing text" 0D
echo(
call %0 "**it requires an " 07 "even-numbered" 0A " amount of arguments to run correctly" 07
echo(
echo(
call %0 "c" 0E "Echo" 08  " help references:" 0C
echo(
call %0 "c" 0E "Echo" 08 " -help " 0C "[" 04 "argument" 0A "]" 04 "  :  " 07 "[" 04 "function" 0A "]" 04
echo(
call %0 "                   -s" 0A "   :  " 07 "syntax" 0D
echo(
call %0 "                   -a" 0A "   :  " 07 "argument pair " 0A "syntax" 0D
echo(
call %0 "                   -c" 0A "   :  " 07 "color code " 0A "syntax" 0D
exit /b

:helpsyntax
call %0 "c" 0E "Echo" 08 " syntax" 0D " is: " 07 "c" 0E "Echo" 08 " [" 04 "argument_pair1" 0A "[ " 04 "argument_pair2" 0A "[ " 04 "..." 0A "]]]" 04
echo(
echo(
call %0 "**look at " 07 "c" 0E "Echo" 08  " -help -a" 0C " for " 07 "argument pair" 0A " syntax" 07
exit /b
:helppair
call %0 "c" 0E "Echo" 08 " - argument pair" 0A " syntax" 0D " is: " 07 "[" 04 "text_to_colorize" 0A "] [" 04 "color_code" 0A "]" 04
echo(
echo(
call %0 "**look at " 07 "c" 0E "Echo" 08  " -help -a" 0C " for " 07 "color code" 0A " syntax" 07
exit /b
:helpreference
call %0 "c" 0E "Echo" 08 " - color code" 0A " syntax" 0D ": " 07
echo(
echo(
call %0 "color codes" 0A " have " 07 "2 characters" 0D ":" 07
echo(
call %0 "1 for the " 07 "background ($)" 9F " and 1 for the " 07 "text color (#)" 0A
echo(
echo(
call %0 "color code " 0A "syntax" 0D " is simple: " 07 "[" 04 "$" 9F "#" 0A "]" 04
echo(
echo(
echo **here is a table of all available color codes
call %0 "color  :" 07 " dark_code" 08 "     : " 07 "bright_code" 0F
echo(
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
