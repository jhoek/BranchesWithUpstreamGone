function Remove-BranchesWithUpstreamGone {
    (Get-BranchesWithUpstreamGone) | ForEach-Object {
      Write-Host "Removing branch $_"
      git branch $_ -D
    }
  }