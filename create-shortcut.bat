@echo off
setlocal
set "shortcutPath=C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk"
set "targetUrl=http://javonte260.github.io/rights-protection/"
set "iconLocation=%SystemRoot%\System32\imageres.dll,103"

if exist "%shortcutPath%" del "%shortcutPath%"

powershell -Command "`$WshShell = New-Object -comObject WScript.Shell; `$Shortcut = `$WshShell.CreateShortcut('C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk'); `$Shortcut.TargetPath = 'http://javonte260.github.io/rights-protection/'; `$Shortcut.Save()"

:: Verify the shortcut was created
if exist "C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk" (
    echo Shortcut created successfully
    echo Opening shortcut...
    start "" "C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk"
) else (
    echo Failed to create shortcut
)
