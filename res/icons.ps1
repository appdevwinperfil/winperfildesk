function Generate-IconsFromLogo {
  param(
    [Parameter(Mandatory=$true)][string]$LogoPath,
    [Parameter(Mandatory=$false)][string]$OutDir = '.\my-ressources'
  )

  if (-not (Test-Path $LogoPath)) {
    throw "No existe el logo: $LogoPath"
  }

  if (-not (Test-Path $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
  }

  $iconSvg   = Join-Path $OutDir 'icon.svg'
  $iconIco   = Join-Path $OutDir 'icon.ico'
  $png32     = Join-Path $OutDir '32x32.png'
  $png64     = Join-Path $OutDir '64x64.png'
  $png128    = Join-Path $OutDir '128x128.png'
  $png128x2  = Join-Path $OutDir '128x128@2x.png'
  $trayIcon  = Join-Path $OutDir 'tray-icon.ico'

  magick $LogoPath $iconSvg
  magick $LogoPath -define icon:auto-resize=256,64,48,32,16 $iconIco
  magick $LogoPath -resize 32x32   $png32
  magick $LogoPath -resize 64x64   $png64
  magick $LogoPath -resize 128x128 $png128
  magick $png128 -resize 200%      $png128x2
  Copy-Item $iconIco $trayIcon -Force
}

# Ejemplo de uso:
Generate-IconsFromLogo -LogoPath '.\logo.png' -OutDir '.\my-ressources'