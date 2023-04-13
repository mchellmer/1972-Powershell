# appstore -> App Installer
# set background: "C:\Users\mchel\OneDrive\Pictures\ff6wallpaper243440x1440.jpg"
winget install -e --id Git.Git
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Google.Chrome
winget install -e --id Microsoft.PowerShell
winget install -e --id 7zip.7zip

# Twitch
## Install font: "C:\Users\mchel\OneDrive\Documents\0_Store\Twitch\04b_30\04B_30__.TTF"
## Streamer.Bot https://streamer.bot/api/releases/streamer.bot/latest/download
winget install --id=OBSProject.OBSStudio  -e
## unzip "C:\Users\mchel\OneDrive\Documents\0_Store\Twitch\Obs\230411_obs-studio.zip" to C:\Users\mchel\AppData\Roaming\obs-studio
winget install -e --id GIMP.GIMP

# Recording
winget install --id=Cockos.REAPER  -e
## https://github.com/Andersama/obs-asio/releases
winget install -e --id Musescore.Musescore