# The Course of Empire: installs the packages and downloads the 56 asset files (about 90 MB).
# Run from this folder in PowerShell:  powershell -ExecutionPolicy Bypass -File setup.ps1
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$B = 'https://assets.uberdesigner.ai/course-of-empire'
Write-Host 'Installing packages...'
npm install
if ($LASTEXITCODE -ne 0) { throw 'npm install failed' }
Write-Host 'Downloading assets...'
$files = @(
  @('assets/audio/night.m4a', 836682),
  @('assets/audio/noon.m4a', 832441),
  @('assets/audio/storm.m4a', 834638),
  @('assets/film/ch1-3d-720.bin', 9809442),
  @('assets/film/ch1-3d-hd.bin', 18112862),
  @('assets/film/ch2-3d-720.bin', 9544614),
  @('assets/film/ch2-3d-hd.bin', 17835140),
  @('assets/film/ch3-3d-720.bin', 6472084),
  @('assets/film/ch3-3d-hd.bin', 12717206),
  @('assets/fonts/cormorant-unicase-latin-400-normal.woff2', 21112),
  @('assets/fonts/cormorant-unicase-latin-500-normal.woff2', 21276),
  @('assets/fonts/cormorant-unicase.LICENSE.txt', 4834),
  @('assets/fonts/geist-latin-300-normal.woff2', 13228),
  @('assets/fonts/geist-latin-400-normal.woff2', 12956),
  @('assets/fonts/geist-latin-500-normal.woff2', 34716),
  @('assets/fonts/geist-mono-latin-200-normal.woff2', 9912),
  @('assets/fonts/geist-mono-latin-300-normal.woff2', 10020),
  @('assets/fonts/geist-mono-latin-400-normal.woff2', 9864),
  @('assets/fonts/geist.LICENSE.txt', 4384),
  @('assets/frames/01.webp', 198344),
  @('assets/frames/02.webp', 400514),
  @('assets/frames/03.webp', 565198),
  @('assets/frames/04.webp', 422804),
  @('assets/frames/05.webp', 433618),
  @('assets/frames/06.webp', 135066),
  @('assets/frames/07.webp', 255858),
  @('assets/frames/08.webp', 365828),
  @('assets/frames/09.webp', 188088),
  @('assets/frames/10.webp', 285130),
  @('assets/frames/11.webp', 270556),
  @('assets/frames/12.webp', 204960),
  @('assets/frames/13.webp', 160718),
  @('assets/hall/bust-normal.webp', 84122),
  @('assets/hall/bust.bin', 521352),
  @('assets/hall/bust.webp', 86036),
  @('assets/hall/floor.webp', 302796),
  @('assets/hall/frame-arm.webp', 33032),
  @('assets/hall/frame-normal.webp', 91634),
  @('assets/hall/frame.webp', 56234),
  @('assets/hall/marble.webp', 74388),
  @('assets/hall/painting-desolation.webp', 891086),
  @('assets/hall/painting.webp', 1266632),
  @('assets/hall/plaster.webp', 49500),
  @('assets/hall/plate-floor-base.webp', 68024),
  @('assets/hall/plate-ruin.webp', 488968),
  @('assets/hall/plate.webp', 682296),
  @('assets/og.jpg', 131191),
  @('assets/paintings/consummation-thumb.webp', 28688),
  @('assets/paintings/consummation.webp', 336928),
  @('assets/paintings/desolation-thumb.webp', 20102),
  @('assets/paintings/desolation.webp', 217872),
  @('assets/paintings/destruction-thumb.webp', 23798),
  @('assets/paintings/destruction.webp', 236756),
  @('assets/ui/cursor-cross.svg', 8140),
  @('js/vendor/three.LICENSE.txt', 1081),
  @('js/vendor/three.module.min.js', 742188)
)
$bad = $false
foreach ($f in $files) {
  $dst = Join-Path 'public' $f[0]
  if ((Test-Path $dst) -and ((Get-Item $dst).Length -eq $f[1])) { Write-Host "  ok (already here) $($f[0])"; continue }
  New-Item -ItemType Directory -Force -Path (Split-Path $dst) | Out-Null
  Invoke-WebRequest -Uri "$B/$($f[0])" -OutFile $dst -UseBasicParsing
  $got = (Get-Item $dst).Length
  if ($got -eq $f[1]) { Write-Host "  ok $($f[0])" } else { Write-Host "  WRONG SIZE $($f[0]) ($got, expected $($f[1]))"; $bad = $true }
}
if ($bad) { Write-Host 'Some files did not download correctly. Run this script again.'; exit 1 }
Write-Host 'Done. Start it with:  npm run dev   then open http://localhost:5173/?q=0'
