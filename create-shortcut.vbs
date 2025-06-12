Set WshShell = CreateObject("WScript.Shell")
Set shortcut = WshShell.CreateShortcut("C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk")
shortcut.TargetPath = "http://javonte260.github.io/rights-protection/"
shortcut.Save
