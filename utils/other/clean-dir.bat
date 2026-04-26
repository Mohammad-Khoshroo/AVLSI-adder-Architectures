@echo off
setlocal

echo === Windows Folder Cleaner ===
set /p TARGET_DIR="Enter directory path (press Enter for current folder): "

if "%TARGET_DIR%"=="" set TARGET_DIR=%CD%

if not exist "%TARGET_DIR%" (
    echo Error: Directory "%TARGET_DIR%" does not exist!
    pause
    exit /b
)

echo.
echo WARNING: This will delete ALL sub-folders inside: %TARGET_DIR%
echo Files in the root of this directory will NOT be deleted.
pause

echo.
echo Deleting folders...
for /d %%D in ("%TARGET_DIR%\*") do (
    echo Deleting: "%%D"
    rd /s /q "%%D"
)

echo.
echo Cleanup Complete!
pause
