# Set the wallpaper
$WallpaperPath = "E:\wallpaper.png"
Copy-Item -Path .\new_wallpaper.png $WallpaperPath
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $WallpaperPath

# Install the fonts
$fontFolder = ".\fonts"
$fontItem = Get-Item -Path $fontFolder
$fontList = Get-ChildItem -Path "$fontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf')

Write-Output "Installieren der Schriftarten..."
foreach ($Font in $FontList) {
    try {
        Copy-Item $Font "C:\Windows\Fonts" -Force
        Set-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Value $Font.name         
    }
    catch {
        Write-Warning "Die Schriftart $Font konnte nicht installiert werden"
    }
}