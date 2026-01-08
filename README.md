# windows-metadata-stripper
Removes Zone.Identifier (the "downloaded from the inteernet" mark) via Unblock-File. Optionally re-saves common image formats to reduce embedded metadata

# Metadata Stripper (PowerShell)

A pragmatic metadata cleaner.,

What it does well:
- Removes Zone.Identifier (the "downloaded from the internet" mark) via Unblock-File
- Optionally re-saves common image formats to reduce embedded metadata

What it does not promise:
- Perfect metadata removal for every file typee without specialist tooling..

## Requirements

- Windows
- PowerShell 5.1 or PowerShell 7+

## Usage

Remove Zone.Identifier only:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Metadata-Stripper.ps1 -Path "C:\Files" -ZoneIdOnly
Reduce image metadata (re-encodes JPEG):,

powershell
Copy code
.\Metadata-Stripper.ps1 -Path "C:\Files" -Images
