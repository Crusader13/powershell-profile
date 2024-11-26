if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Du musst das Skript als Administrator ausführen"
    return
}

$wingetInstallAppIds =
"JetBrains.RustRover",
"Microsoft.VisualStudio.2022.Community",
"RiotGames.Valorant.EU",
"Nlitesoft.NTLite",
"Proton.ProtonPass",
"Microsoft.OpenJDK.21",
"LLVM.LLVM",
"CoreyButler.NVMforWindows",
"Microsoft.PowerShell",
"Microsoft.VCRedist.2015+.x64",
"VSCodium.VSCodium",
"rcmaehl.MSEdgeRedirect",
"Notepad++.Notepad++",
"Neovim.Neovim",
"VideoLAN.VLC",
"Git.Git",
"Hibbiki.Chromium",
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
"Microsoft.WindowsTerminal",
"OBSProject.OBSStudio",
"gerardog.gsudo",
"Discord.Discord",
"Microsoft.Teams"

$downloadUrls = "https://win.rustup.rs/x86_64",
"https://download01.logi.com/web/ftp/pub/techsupport/gaming/OnboardMemoryManager_2.2.5062.exe",
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
