:: Inpired by Windows version https://gist.github.com/thebagchi/df29ae862fc1c296dec2
:: Which is inspired by Linux version of the same https://gist.github.com/christopherperry/3208109

@echo off
SET ARGUMENTS=%*

if "%ARGUMENTS%" == "" (
    GOTO EOF
)

SET "ARGUMENTS=%ARGUMENTS:""="%"

SETLOCAL ENABLEDELAYEDEXPANSION
:: EXECUTE SHELL COMMAND ON ALL ATTACHED DEVICES ::
if not exist %1 mkdir %1
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
	SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
	    if not exist "%1/!SERIAL!" mkdir "%1/!SERIAL!"
	    set storage=
	    for /f "delims=" %%A in ('adb -s !SERIAL! shell echo $EXTERNAL_STORAGE') do SET storage=%%A
	    set storage=!storage!/Download/jgiven-reports
	    echo "Storage: !storage!"
	    call adb -s !SERIAL! pull /!storage!/ %1/!SERIAL!/
	)
)
ENDLOCAL
:EOF