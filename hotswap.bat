@echo off
rem this is a comment

rem DEBUG: set default location of xplane aircraft folder
set defaultloc="D:\Documents\programs\X-Plane 11\Aircraft\chai112\b777-300er\plugins\saslfree\data\modules\custom module" 
rem DEBUG: set key for the user to enter for it to convert to default location
set defaultkey=a

echo ====================================================
echo Thank you for downloading Chai112's Boeing 777-300ER
echo ====================================================

echo I will build and extract the PLUGINS from the repo.
echo Please enter destination of where X-Plane's aircraft:
set /P dest="> "

if %dest%==%defaultkey% ^
set dest=%defaultloc%

echo Extracting aircraft to %dest%
echo Alt+F4 to cancel.
timeout 5



rem /e is recursive
rem /h is hidden files
rem /y is without prompt
xcopy src\external\code "src\base\b777-300ER\plugins\saslfree\data\modules\custom module\" /e/h/y
xcopy src\external\code %dest% /e/h/y

pause
