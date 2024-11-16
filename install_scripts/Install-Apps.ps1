if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Du musst das Skript als Administrator ausführen"
    return
}

$wingetInstallAppIds = "JetBrains.RustRover",
"Microsoft.VisualStudio.2022.Community",
"RiotGames.Valorant.EU",
"RiotGames.LeagueOfLegends.EUW",
"Nlitesoft.NTLite",
"Proton.ProtonPass",
"Microsoft.OpenJDK.21",
"LLVM.LLVM",
"CoreyButler.NVMforWindows"

$downloadUrls = "https://win.rustup.rs/x86_64"

foreach ($app in $wingetInstallAppIds) {
    winget install --exact --id $app --scope machine --accept-source-agreements --accept-package-agreements
}

# use latest npm version
$nvmVersion = "latest"
nvm install $nvmVersion
nvm use $nvmVersion
