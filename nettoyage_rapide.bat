@echo off
REM ========================================
REM Script de nettoyage systeme Windows 11
REM Supprime fichiers temp + Vide DNS + ARP
REM ========================================

echo.
echo ==========================================
echo   NETTOYAGE SYSTEME WINDOWS
echo ==========================================
echo.

REM Verification des privileges administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERREUR : Ce script necessite les droits administrateur
    echo Faites un clic droit sur le fichier et selectionnez "Executer en tant qu'administrateur"
    echo.
    pause
    exit /b 1
)

echo [1/5] Suppression des fichiers temporaires Windows...
del /q /f /s %TEMP%\* >nul 2>&1
rd /s /q %TEMP% >nul 2>&1
mkdir %TEMP% >nul 2>&1
echo       OK - Fichiers temp utilisateur supprimes

del /q /f /s C:\Windows\Temp\* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
mkdir C:\Windows\Temp >nul 2>&1
echo       OK - Fichiers temp Windows supprimes

echo.
echo [2/5] Vidage du cache DNS...
ipconfig /flushdns >nul 2>&1
if %errorLevel% equ 0 (
    echo       OK - Cache DNS vide
) else (
    echo       ERREUR lors du vidage du cache DNS
)

echo.
echo [3/5] Vidage du cache ARP...
arp -d * >nul 2>&1
if %errorLevel% equ 0 (
    echo       OK - Cache ARP vide
) else (
    echo       ERREUR lors du vidage du cache ARP
)

echo.
echo [4/5] Vidage du cache NetBIOS...
nbtstat -R >nul 2>&1
nbtstat -RR >nul 2>&1
echo       OK - Cache NetBIOS vide

echo.
echo [5/5] Renouvellement de la configuration IP...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo       OK - Configuration IP renouvelee

echo.
echo ==========================================
echo   NETTOYAGE TERMINE AVEC SUCCES !
echo ==========================================
echo.
echo Votre systeme a ete nettoye :
echo   - Fichiers temporaires supprimes
echo   - Cache DNS vide
echo   - Cache ARP vide
echo   - Cache NetBIOS vide
echo   - Configuration IP renouvelee
echo.
echo Aucun redemarrage necessaire.
echo.
pause
