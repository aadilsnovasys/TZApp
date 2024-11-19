Import-Module WebAdministration
$siteName = 'TZApp'
$physicalPath = 'C:\web\TZApp'
$port = 80

# Check if the site exists
if (!(Get-Website | Where-Object { $_.Name -eq $siteName })) {
  Write-Host 'Creating new IIS site: $siteName'
  New-Website -Name $siteName -PhysicalPath $physicalPath -Port $port -ApplicationPool 'DefaultAppPool'
} else {
  Write-Host 'IIS site $siteName already exists. Updating physical path.'
  Set-ItemProperty 'IIS:\Sites\$siteName' -Name physicalPath -Value $physicalPath
}

# Ensure the site is running
Start-Website -Name $siteName
