$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk")
$Shortcut.TargetPath = "http://javonte260.github.io/rights-protection/"
$Shortcut.Save()
