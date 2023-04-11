function Get-DirectoryStats {

    param( $directory )
  
    $files = $directory | Get-ChildItem -Force -Recurse | Where-Object { -not $_.PSIsContainer }
    if ( $files ) {
      $output = $files | Measure-Object -Sum -Property Length | Select-Object `
        @{Name="Path"; Expression={$directory}},
        @{Name="Files"; Expression={$_.Count; $script:totalcount += $_.Count}},
        @{Name="Size"; Expression={$_.Sum; $script:totalbytes += $_.Sum}}
  
    }
  
    else {
  
      $output = "" | Select-Object `
        @{Name="Path"; Expression={$directory.FullName}},
        @{Name="Files"; Expression={0}},
        @{Name="Size"; Expression={0}}
    }
  
    $output
  
}
  
$dir = 'C:\Users\mchel\OneDrive\Documents'

gci 'C:\Users\mchel\OneDrive\Documents' | ForEach-Object {"$_.Name: " + $(Get-DirectoryStats -directory "$dir\$($_.Name)")}