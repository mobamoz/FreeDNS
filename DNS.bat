@echo off
echo Designed by Sohrab (mobamoz)
:mainMenu
echo Choose your internet connection:
echo 1. Wi-Fi
echo 2. Ethernet
set /p connectionChoice="Your choice (1 or 2): "

if "%connectionChoice%"=="1" (
    set connection=Wi-Fi
) else if "%connectionChoice%"=="2" (
    set connection=Ethernet
) else (
    echo Invalid choice. Please try again.
    goto mainMenu
)

:dnsMenu
echo.
echo Choose a DNS:
echo 1. Google DNS
echo 2. Cloudflare DNS
echo 3. OpenDNS
echo 4. Electro DNS
echo 5. Radar DNS
echo 6. Shecan DNS
echo 7. Pishgaman DNS
echo 8. Shatel DNS
echo 9. Radar Game DNS
echo 10. Back to connection selection
echo 11. Restore to Windows Default DNS
set /p dnsChoice="Your choice (1-11): "

if "%dnsChoice%"=="1" (
    set dns1=8.8.8.8
    set dns2=8.8.4.4
) else if "%dnsChoice%"=="2" (
    set dns1=1.1.1.1
    set dns2=1.0.0.1
) else if "%dnsChoice%"=="3" (
    set dns1=208.67.222.222
    set dns2=208.67.220.220
) else if "%dnsChoice%"=="4" (
    set dns1=78.157.42.101
    set dns2=78.157.42.100
) else if "%dnsChoice%"=="5" (
    set dns1=185.51.200.2
    set dns2=185.51.200.3
) else if "%dnsChoice%"=="6" (
    set dns1=178.22.122.100
    set dns2=185.51.200.2
) else if "%dnsChoice%"=="7" (
    set dns1=5.202.100.100
    set dns2=5.202.100.101
) else if "%dnsChoice%"=="8" (
    set dns1=85.114.40.14
    set dns2=85.114.40.15
) else if "%dnsChoice%"=="9" (
    set dns1=10.202.10.10
    set dns2=10.202.10.10
) else if "%dnsChoice%"=="10" (
    goto mainMenu
) else if "%dnsChoice%"=="11" (
    echo Restoring default Windows DNS settings...
    netsh interface ip set dns name="%connection%" dhcp
    echo Default DNS settings restored successfully.
    pause
    goto dnsMenu
) else (
    echo Invalid choice. Please try again.
    goto dnsMenu
)

echo Configuring DNS for %connection% connection...
netsh interface ip set dns name="%connection%" static %dns1%
netsh interface ip add dns name="%connection%" %dns2% index=2

echo DNS settings applied successfully.
pause
goto dnsMenu
