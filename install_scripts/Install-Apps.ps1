if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Du musst das Skript als Administrator ausführen"
    return
}

Function Get-RedirectedUrl {

    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()

    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

$wingetInstallAppIds =
"JetBrains.RustRover",
"Microsoft.VisualStudio.2022.Community",
"RiotGames.Valorant.EU",
"RiotGames.LeagueOfLegends.EUW",
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


$downloadUrls = "https://win.rustup.rs/x86_64"

Write-Output "Herunterladen der Programme mit winget"
foreach ($app in $wingetInstallAppIds) {
    winget install --exact --id $app --scope machine --accept-source-agreements --accept-package-agreements
}


$downloadDir = New-Item -ItemType Directory downloaded
Write-Output "Herunterladen der installer im Ordner: $downloadDir"
foreach ($url in $downloadUrls) {
    $FileName = [System.IO.Path]::GetFileName((Get-RedirectedUrl "$url"))
    Invoke-WebRequest -OutFile .\$downloadDir\$FileName $url
}


# use latest npm version
$nvmVersion = "latest"
nvm install $nvmVersion
nvm use $nvmVersion
