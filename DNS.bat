@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Get the active network interface
powershell -Command "(Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }).InterfaceAlias" > netinfo.txt
set /p ActiveNet=<netinfo.txt
del netinfo.txt

if "%ActiveNet%"=="" (
    echo ❌ No active network interface found. Please disconnect VPN and try again.
    pause
    exit /b
)

:menu
cls
echo ================================
echo        DNS Selection Menu
echo ================================
echo 1. Shecan
echo 2. Pishgaman
echo 3. Electro
echo 4. Radar Game
echo 5. UltraDNS
echo 6. FiveM3
echo 7. Google
echo 8. Quad9
echo 9. Cloudflare
echo 10. Restore default DNS settings
echo 11. Exit
echo.

set /p choice="Enter your choice (1-11): "

:: Validate the choice input
if "%choice%"=="1" (
    set DNS1=178.22.122.100
    set DNS2=185.51.200.2
    set DNSNAME=Shecan
)
if "%choice%"=="2" (
    set DNS1=5.202.100.100
    set DNS2=5.202.100.101
    set DNSNAME=Pishgaman
)
if "%choice%"=="3" (
    set DNS1=78.157.42.101
    set DNS2=78.157.42.100
    set DNSNAME=Electro
)
if "%choice%"=="4" (
    set DNS1=10.202.10.10
    set DNS2=10.202.10.10
    set DNSNAME=RadarGame
)
if "%choice%"=="5" (
    set DNS1=156.154.70.1
    set DNS2=156.154.71.1
    set DNSNAME=UltraDNS
)
if "%choice%"=="6" (
    set DNS1=185.212.200.200
    set DNS2=185.212.200.201
    set DNSNAME=FiveM3
)
if "%choice%"=="7" (
    set DNS1=8.8.8.8
    set DNS2=8.8.4.4
    set DNSNAME=Google
)
if "%choice%"=="8" (
    set DNS1=9.9.9.9
    set DNS2=149.112.112.112
    set DNSNAME=Quad9
)
if "%choice%"=="9" (
    set DNS1=1.1.1.1
    set DNS2=1.0.0.1
    set DNSNAME=Cloudflare
)
if "%choice%"=="10" (
    echo Restoring default DNS settings...
    netsh interface ip set dns name="%ActiveNet%" source=dhcp >nul
    echo ✅ DNS reset to default.
    pause
    goto menu
)
if "%choice%"=="11" (
    exit /b
)

:: Handle invalid input
if "%choice%" lss "1" (
    echo ❌ Invalid choice. Please select a valid option.
    pause
    goto menu
)

:: Clear DNS cache
ipconfig /flushdns >nul

:: Set the new DNS
netsh interface ip set dns name="%ActiveNet%" static %DNS1% primary >nul
netsh interface ip add dns name="%ActiveNet%" %DNS2% index=2 >nul

:: Check if DNS change was successful
if %errorlevel% neq 0 (
    echo ❌ Failed to set DNS. Please check the network connection and try again.
    pause
    goto menu
)

echo ✅ DNS set to %DNSNAME%.
echo 📡 Active Network: %ActiveNet%

:: Display current DNS settings
echo -------------------------------
echo 🔍 Current DNS settings:
powershell -Command "Get-DnsClientServerAddress -InterfaceAlias '%ActiveNet%' | Select-Object -ExpandProperty ServerAddresses"
echo -------------------------------

pause
goto menu
