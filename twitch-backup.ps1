# Get drives
$archiveA = Get-Volume -FileSystemLabel "ArchiveA"
$archiveB = Get-Volume -FileSystemLabel "ArchiveB"
$archiveAPath = "$($archiveA.DriveLetter):"
$archiveBPath = "$($archiveB.DriveLetter):"

# Twitch Folder
$twitchPath = "C:/Users/mchel/OneDrive/Documents/0_Store/Twitch/*"
Copy-Item -Path $twitchPath -Destination "$archiveAPath/Twitch" -Recurse -Force
Copy-Item -Path "$archiveAPath/Twitch" -Destination "$archiveBPath/Twitch" -Recurse -Force

# Obs Folder
$obsPath = "C:/Users/mchel/AppData/Roaming/obs-studio/*"
Copy-Item -Path $obsPath -Destination "$archiveAPath/Obs" -Recurse -Force
Copy-Item -Path "$archiveAPath/Obs" -Destination "$archiveBPath/Obs" -Recurse -Force

# Tracks
$scoresPath = "C:/Users/mchel/OneDrive/Documents/MuseScore4/Scores/*"
Copy-Item -Path $scoresPath -Destination "$archiveAPath/Scores" -Recurse -Force
Copy-Item -Path "$archiveAPath/Scores" -Destination "$archiveBPath/Scores" -Recurse -Force

# Recordings
$recordingsPath = "C:/Users/mchel/Videos/*"
$excludeSource = Get-ChildItem -recurse $recordingsPath
$excludeA = Get-ChildItem -recurse "$archiveAPath/Recordings"
Copy-Item -Path $recordingsPath -Destination "$archiveAPath/Recordings" -Recurse -Exclude $excludeSource
Copy-Item -Path "$archiveAPath/Recordings/*" -Destination "$archiveBPath/Recordings" -Recurse -Exclude $excludeA
