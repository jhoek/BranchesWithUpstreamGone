function Get-BranchesWithUpstreamGone
{
    param
    (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$Directory = '.',

        [switch]$SkipFetch
    )

    if (-not $SkipFetch)
    {
        $FetchOutput = git -C $Directory fetch --all --prune 2>&1
        if ($LastExitCode) { throw $FetchOutput }
    }

    git -C $Directory branch -v
    | Where-Object { $_.Contains('[gone]') }
    | ForEach-Object {
        if ($_.Split(' ').Item(1) -ne '')
        {
            $_.Split(' ').Item(1)
        }
        else
        {
            $_.Split(' ').Item(2)
        }
    }
}