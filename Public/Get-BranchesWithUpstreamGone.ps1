function Get-BranchesWithUpstreamGone {
    git fetch --all --prune 2>&1 | Out-Null

    git branch -v
    | Where-Object { $_.Contains('[gone]') }
    | ForEach-Object {
      if ($_.Split(' ').Item(1) -ne '') {
        $_.Split(' ').Item(1)
      }
      else {
        $_.Split(' ').Item(2)
      }
    }
  }