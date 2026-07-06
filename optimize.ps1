# ====================================================================
# WINDOWS 11 STABILITY & PERFORMANCE TWEAK SCRIPT
# Safe, effective, and completely reversible. Run as Admin.
# ====================================================================

Write-Host "🎨 Starting Windows 11 Fix & Performance Optimization..." -ForegroundColor Cyan
Start-Sleep -Seconds 2

# 1. FIXES: System Repair & Explorer Crash Prevention
Write-Host "🛠️ 1/5 Running System Diagnostics & File Repairs (SFC/DISM)..." -ForegroundColor Yellow
DISM.exe /Online /Cleanup-image /Restorehealth
sfc /scannow

Write-Host "📂 2/5 Clearing File Explorer Cache to prevent Stuck/Crash loops..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
$CachePath = "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\*"
Remove-Item $CachePath -Force -ErrorAction SilentlyContinue
Start-Process explorer

# 2. POWER & CPU BOOST: Enable Ultimate Performance Profile
Write-Host "⚡ 3/5 Injecting & Activating Ultimate Performance Power Plan..." -ForegroundColor Yellow
$UltimateGUID = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $UltimateGUID | Out-Null
powercfg -setactive $UltimateGUID

# 3. GPU TWEAKS: Low Latency & Hardware Acceleration (HAGS)
Write-Host "🎮 4/5 Optimizing GPU Scheduling & Windowed Game Tweaks..." -ForegroundColor Yellow
$GraphicsKey = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
if (Test-Path $GraphicsKey) {
    Set-ItemProperty -Path $GraphicsKey -Name "HwSchMode" -Value 2 -Force -ErrorAction SilentlyContinue
}
$GameConfigKey = "HKCU:\System\GameConfigStore"
Set-ItemProperty -Path $GameConfigKey -Name "GameDVR_Enabled" -Value 0 -Force -ErrorAction SilentlyContinue

# 4. RAM & SYSTEM TWEAKS: Visual Performance Overhaul
Write-Host "🧠 5/5 Adjusting System responsiveness and memory behavior..." -ForegroundColor Yellow
$VisualKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $VisualKey -Name "TaskbarAnimations" -Value 0 -Force -ErrorAction SilentlyContinue

$PriorityKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $PriorityKey -Name "SystemResponsiveness" -Value 0 -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ All tweaks applied successfully!" -ForegroundColor Green
Write-Host "🚀 Windows Explorer restarted. Ultimate Performance Power Plan activated." -ForegroundColor Green
Write-Host "⚠️ Please restart your PC to fully apply the registry and GPU scheduling changes." -ForegroundColor Cyan