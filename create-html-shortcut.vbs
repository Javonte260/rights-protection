Set WshShell = CreateObject("WScript.Shell")
Set shortcut = WshShell.CreateShortcut("C:\Users\Javonte\Desktop\SafeDocsGenerator Website.lnk")
shortcut.TargetPath = "C:\Users\Javonte\Desktop\rights-protection\website-link.html"
shortcut.Save
