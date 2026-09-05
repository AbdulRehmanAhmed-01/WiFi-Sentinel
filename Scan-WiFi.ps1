$raw=netsh wlan show networks mode=bssid
$items=@();$ssid=$null;$auth='';$enc='';$bssid='';$signal=0;$have=$false
function Add-Item { if($script:have -and $null -ne $script:ssid){$script:items += [PSCustomObject]@{ssid=$script:ssid;authentication=$script:auth;encryption=$script:enc;bssid=$script:bssid;signal=$script:signal}}}
foreach($line in $raw){
 if($line -match '^\s*SSID\s+\d+\s*:\s*(.*)$'){Add-Item;$ssid=$Matches[1].Trim();$auth='';$enc='';$bssid='';$signal=0;$have=$false}
 elseif($line -match '^\s*Authentication\s*:\s*(.*)$'){$auth=$Matches[1].Trim()}
 elseif($line -match '^\s*Encryption\s*:\s*(.*)$'){$enc=$Matches[1].Trim()}
 elseif($line -match '^\s*BSSID\s+\d+\s*:\s*(.*)$'){if($have){Add-Item};$bssid=$Matches[1].Trim();$signal=0;$have=$true}
 elseif($line -match '^\s*Signal\s*:\s*(\d+)%'){$signal=[int]$Matches[1]}
}
Add-Item
$json=@($items)|ConvertTo-Json -Compress
"window.WIFI_DATA = $json;" | Set-Content (Join-Path $PSScriptRoot 'wifi-data.js') -Encoding UTF8
Write-Host "Scan complete: $($items.Count) access points found." -ForegroundColor Green
