function Remove-BranchesWithUpstreamGone {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param
    (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$Directory = '.',

        [switch]$SkipFetch
    )

    Get-BranchesWithUpstreamGone `
        -Directory $Directory `
        -SkipFetch:$SkipFetch |
    ForEach-Object {
        if ($PSCmdlet.ShouldProcess("Branch $_ would be deleted.", "Delete branch $_", 'Remove-BranchesWithUpstreamGone')) {
            git -C $Directory branch $_ -D
        }
    }
}