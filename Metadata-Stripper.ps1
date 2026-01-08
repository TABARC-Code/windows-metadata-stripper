# TABARC-Code
param(
  [Parameter(Mandatory=$true)][string]$Path,
  [switch]$Images,
  [switch]$ZoneIdOnly
)

Add-Type -AssemblyName System.Drawing

$Path = (Resolve-Path -LiteralPath $Path).Path
$files = Get-ChildItem -LiteralPath $Path -Recurse -File -Force

foreach ($f in $files) {
  try { Unblock-File -LiteralPath $f.FullName -ErrorAction SilentlyContinue } catch {}
}

if ($ZoneIdOnly) {
  Write-Host "Zone.Identifier removal completed."
  exit 0
}

if (-not $Images) {
  Write-Host "No deep stripping performed. Use -Images or -ZoneIdOnly."
  exit 0
}

foreach ($f in $files) {
  $ext = $f.Extension.ToLowerInvariant()
  if ($ext -notin ".jpg",".jpeg",".png",".bmp",".gif",".tif",".tiff") { continue }

  try {
    $img = [System.Drawing.Image]::FromFile($f.FullName)
    $tmp = "$($f.FullName).tmp"

    if ($ext -in ".jpg",".jpeg") { $img.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Jpeg) }
    elseif ($ext -eq ".png") { $img.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png) }
    else { $img.Save($tmp) }

    $img.Dispose()
    Move-Item -LiteralPath $tmp -Destination $f.FullName -Force
    Write-Host "Re-saved: $($f.FullName)"
  } catch {
    Write-Host "Failed: $($f.FullName) $($_.Exception.Message)"
  }
}
