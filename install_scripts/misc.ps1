# Set the wallpaper
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value .\new_wallpaper.png

# Install the fonts
$fontFolder = ".\fonts"
$fontItem = Get-Item -Path $fontFolder
$fontList = Get-ChildItem -Path "$fontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf')

foreach ($Font in $FontList) {
    Write-Host -NoNewLine 'Installing font - ' $Font.BaseName
    Copy-Item $Font "C:\Windows\Fonts"
    New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name         
}