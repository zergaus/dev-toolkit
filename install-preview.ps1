[CmdletBinding()]
param(
    [string[]]$CoreArguments = @(),
    [string]$StateRoot = (Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

throw 'DevToolkit preview v0.1.0-preview.20260827.10 is under SECURITY HOLD. Do not download or run this candidate.'
