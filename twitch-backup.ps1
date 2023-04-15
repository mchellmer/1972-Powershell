function Get-ArchivesAB {
    param (
        $archiveAFriendlyName="ArchiveA",
        $archiveBFriendlyName="ArchiveB"
    )
    # Get drives
    $archiveA = Get-Volume -FileSystemLabel $archiveAFriendlyName
    $archiveB = Get-Volume -FileSystemLabel $archiveBFriendlyName
    $archiveAPath = "$($archiveA.DriveLetter):"
    $archiveBPath = "$($archiveB.DriveLetter):"
    return $archiveAPath, $archiveBPath
}

function Invoke-Archive {
    param (
        $primaryPath,
        $secondaryPath,
        $dataPath,
        $tag,
        $method
    )

    if ($method -eq "overwriteZip") {
        Invoke-7ip $dataPath $tag "archive"

        $soureZip = "$dataPath/$tag.7z"
        $destZipA = "$primaryPath/$tag.7z"
        $destZipB = "$secondaryPath/$tag.7z"
    
        Write-Host "Copy archive $soureZip to $destZipA and $destZipB"
        Copy-Item -Path $soureZip -Destination $destZipA -Force
        Copy-Item -Path $soureZip -Destination $destZipB -Force
        Remove-Item $soureZip
    } elseif ($method -eq "update") {
        robocopy /xc /xn /xo /E $dataPath "$primaryPath/$tag"
        robocopy /xc /xn /xo /E $dataPath "$secondaryPath/$tag"
    }
}

function Invoke-7ip {
    param (
        $zipDir,
        $tag,
        $method
    )
    $7zipPath = "$env:ProgramFiles/7-Zip/7z.exe"

    if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
        throw "7 zip file '$7zipPath' not found"
    }

    Set-Alias Start-SevenZip $7zipPath

    if ($method -eq "archive") {
        $Source = $zipDir
        $Target = "$($zipDir)/$($tag).7z"
    
        write-host "Packing $zipDir"
        Start-SevenZip a -aoa -t7z -mx=9 $Target $Source
    } elseif ($method -eq "overwrite") {
        write-host "Unpacking $zipDir"
        Start-SevenZip x -aoa $zipDir
    }
}

$archiveDirs = @(
    @{
        localPath="C:/Users/mchel/OneDrive/Documents/0_Store/Twitch";
        tag="Twitch";
        method="overwriteZip"
    },
    @{
        localPath="C:/Users/mchel/AppData/Roaming/obs-studio";
        tag="Obs";
        method="overwriteZip"
    },
    @{
        localPath="C:/Users/mchel/OneDrive/Documents/MuseScore4/Scores";
        tag="Scores";
        method="overwriteZip"
    },
    @{
        localPath="C:/Users/mchel/Videos";
        tag="Recordings";
        method="update"
    }
)

$archiveA, $archiveB = Get-ArchivesAB

foreach ($archiveDict in $archiveDirs) {
    Invoke-Archive $archiveA $archiveB $archiveDict.localPath $archiveDict.tag $archiveDict.method
}