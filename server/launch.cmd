@echo off
rem VideoRecompress Studio MCP launcher for the Claude Code plugin. Starts the app's own MCP server
rem ("videorecompress serve") and passes stdin/stdout straight through; nothing else runs, nothing is downloaded.
rem Lookup order: CONTENTASOFT_VR_EXE override, per-user install, PATH, Program Files.
rem If the app is not installed: node index.js (the full launcher) when Node.js exists, otherwise
rem stub.ps1 (Windows PowerShell, always present) serves one tool, get_started, with the download link.
setlocal
set "EXE="
if defined CONTENTASOFT_VR_EXE if exist "%CONTENTASOFT_VR_EXE%" set "EXE=%CONTENTASOFT_VR_EXE%"
if not defined EXE if exist "%LOCALAPPDATA%\Programs\VideoRecompressStudio\videorecompress.exe" set "EXE=%LOCALAPPDATA%\Programs\VideoRecompressStudio\videorecompress.exe"
if not defined EXE for /f "delims=" %%P in ('where videorecompress.exe 2^>nul') do if not defined EXE set "EXE=%%P"
if not defined EXE if exist "%ProgramFiles%\VideoRecompressStudio\videorecompress.exe" set "EXE=%ProgramFiles%\VideoRecompressStudio\videorecompress.exe"
if not defined EXE if exist "%ProgramFiles(x86)%\VideoRecompressStudio\videorecompress.exe" set "EXE=%ProgramFiles(x86)%\VideoRecompressStudio\videorecompress.exe"
if defined EXE goto run
where node >nul 2>nul
if not errorlevel 1 goto node
powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%~dp0stub.ps1"
exit /b %errorlevel%
:node
node "%~dp0index.js"
exit /b %errorlevel%
:run
"%EXE%" serve
exit /b %errorlevel%
