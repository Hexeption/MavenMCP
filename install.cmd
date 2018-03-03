@echo OFF
TITLE Install and setup MCP
COLOR 0F
SETLOCAL ENABLEDELAYEDEXPANSION
CLS

:: 1.12.1 Version
SET MCP_LK=http://www.modcoderpack.com/files/mcp940.zip
SET MC_VEV=1.12

:: Downloading Beta MCP
:: TODO Check if there is already and tmp folder
ECHO Downloading MCP...
DEL tmp /S /Q /F
MD tmp
CD tmp
powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;(New-Object Net.WebClient).DownloadFile('%MCP_LK%', 'mcp.zip')"
ECHO.

:: Unzipping MCP
ECHO Unzipping MCP...
powershell "Expand-Archive mcp.zip -DestinationPath ."
DEL mcp.zip
ECHO.

:: Executing MCP
ECHO Executing MCP...
runtime\bin\python\python_mcp runtime\decompile.py %*
CD ..
ECHO.

:: Copy the sources from temp to main
ECHO Copying Sources...
ROBOCOPY tmp\src\minecraft\ src\main\java /E
ECHO.

ECHO Rearrange..
MOVE src\main\java\Start.java src\main\java\net\minecraft\Start.java
ECHO.

ECHO Copying workspace..
ROBOCOPY tmp\jars\ workspace\ /MIR
ECHO.

:: Clean Up
ECHO Clean Up..
RMDIR tmp /S /Q
ECHO.

ECHO Done.
ECHO.

PAUSE