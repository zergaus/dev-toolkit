[CmdletBinding()]
param(
    [string[]]$CoreArguments = @(),
    [string]$StateRoot = (Join-Path $env:LOCALAPPDATA 'DevToolkit\bootstrap')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$version = '0.1.0-preview.20260828.12'
$releaseRoot = "https://github.com/zergaus/dev-toolkit/releases/download/v$version"
$manifestUri = "$releaseRoot/release-manifest.json"
$manifestSha256 = 'E8F35DAFE09646A7FE928E8AAC022D5E46D578C209226B968844405632E28FA8'
$allowedHost = @('github.com', 'release-assets.githubusercontent.com')
$allowedQueryRedirectHost = @('release-assets.githubusercontent.com')
$bootstrapRoot = Join-Path $env:LOCALAPPDATA "DevToolkit\preview-bootstrap\$version"

function Get-Sha256 {
    param([Parameter(Mandatory = $true)][string]$LiteralPath)
    return (Get-FileHash -LiteralPath $LiteralPath -Algorithm SHA256).Hash.ToUpperInvariant()
}

function Save-PinnedFile {
    param(
        [Parameter(Mandatory = $true)][string]$Uri,
        [Parameter(Mandatory = $true)][string]$ExpectedSha256,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    if (Test-Path -LiteralPath $Destination) {
        if ((Get-Sha256 -LiteralPath $Destination) -ne $ExpectedSha256) {
            throw "Existing pinned bootstrap file conflicts with expected SHA-256: $Destination"
        }
        return
    }

    $partial = "$Destination.partial.$PID"
    $lastError = $null
    for ($attempt = 1; $attempt -le 2; $attempt++) {
        try {
            if (Test-Path -LiteralPath $partial) { Remove-Item -LiteralPath $partial -Force }
            Invoke-WebRequest -UseBasicParsing -Uri $Uri -OutFile $partial -TimeoutSec 120
            if ((Get-Item -LiteralPath $partial).Length -gt 2097152) {
                throw 'Pinned bootstrap file exceeds the 2 MiB bound.'
            }
            $observed = Get-Sha256 -LiteralPath $partial
            if ($observed -ne $ExpectedSha256) {
                throw "Pinned bootstrap SHA-256 mismatch. Expected $ExpectedSha256; observed $observed."
            }
            Move-Item -LiteralPath $partial -Destination $Destination
            return
        }
        catch {
            $lastError = $_
        }
    }

    if (Test-Path -LiteralPath $partial) { Remove-Item -LiteralPath $partial -Force }
    throw "Pinned bootstrap download failed after 2 attempts: $($lastError.Exception.Message)"
}

[void](New-Item -ItemType Directory -Path $bootstrapRoot -Force)
$trustPath = Join-Path $bootstrapRoot 'ReleaseTrust.psm1'
$bootstrapPath = Join-Path $bootstrapRoot 'Invoke-ImmutableBootstrap.ps1'

Save-PinnedFile -Uri "$releaseRoot/ReleaseTrust.psm1" -ExpectedSha256 '4349473B7784DE359694AC63A928256B7099C24C26EC378E737AA3BA589E00DC' -Destination $trustPath
Save-PinnedFile -Uri "$releaseRoot/Invoke-ImmutableBootstrap.ps1" -ExpectedSha256 'A0B3A771605139280690AA82208DE550033F3BBF59EC83BF6DC0B054594CC330' -Destination $bootstrapPath

& $bootstrapPath -ManifestUri $manifestUri -ExpectedManifestSha256 $manifestSha256 -AllowedHost $allowedHost -AllowedQueryRedirectHost $allowedQueryRedirectHost -CoreArguments $CoreArguments -StateRoot $StateRoot
exit $LASTEXITCODE
