if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Du musst das Skript als Administrator ausführen"
    return
}

$wingetInstallAppIds =
"JetBrains.PyCharm.Community",
"JetBrains.RustRover",
"RiotGames.Valorant.EU",
"Nlitesoft.NTLite",
"LLVM.LLVM",
"Microsoft.OpenJDK.21",
"CoreyButler.NVMforWindows",
"Microsoft.VisualStudio.2022.Community",
"Microsoft.PowerShell",
"Microsoft.VCRedist.2015+.x64",
"Microsoft.DotNet.DesktopRuntime.9",
"Microsoft.WindowsTerminal",
"VSCodium.VSCodium",
"rcmaehl.MSEdgeRedirect",
"Notepad++.Notepad++",
"Neovim.Neovim",
"VideoLAN.VLC",
"Git.Git",
"Valve.Steam",
"GitHub.GitHubDesktop",
"JanDeDobbeleer.OhMyPosh",
"Gyan.FFmpeg",
"Guru3D.Afterburner",
"7zip.7zip",
"ajeetdsouza.zoxide",
"ShareX.ShareX",
"Nextcloud.NextcloudDesktop",
"yt-dlp.yt-dlp",
"OBSProject.OBSStudio",
"gerardog.gsudo",
"Discord.Discord",
"Microsoft.Teams",
"Alex313031.Thorium.AVX2"

$downloadUrls = 
"https://download01.logi.com/web/ftp/pub/techsupport/gaming/OnboardMemoryManager_2.4.8406.exe",
"https://github.com/geovens/gInk/releases/download/v1.1.1/gInk_v1.1.1.zip",
"https://github.com/Collective-Software/ClickPaste/releases/download/v1.3.0/ClickPaste_v1.3.0.zip"

Write-Output "Herunterladen der Programme mit winget"
foreach ($app in $wingetInstallAppIds) {
    Write-Output "Installieren von $app"
    winget install --exact --id $app --accept-source-agreements --accept-package-agreements
}

$downloadDir = New-Item -ItemType Directory downloaded
$prevLocation = Get-Location
Set-Location $downloadDir

Write-Output "Herunterladen der installer im Ordner: $downloadDir"
foreach ($url in $downloadUrls) {
    curl.exe -O $url
}
Set-Location $prevLocation

# use latest npm version
$nvmVersion = "latest"
nvm install $nvmVersion
nvm use $nvmVersion

# set JAVA_HOME environment variable
$JavaPath = "C:\Program Files\Microsoft\jdk-21.0.5.11-hotspot"
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JavaPath, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('Path', "$env:PATH;%JAVA_HOME%\bin", [System.EnvironmentVariableTarget]::Machine)
