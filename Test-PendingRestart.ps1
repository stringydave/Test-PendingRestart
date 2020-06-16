<#
Powershell script to return 1 if a Restart is Pending

Usage: Test-PendingRestart.ps1
return: 0   no Pending Restart detected
return: 1   Pending Restart detected

Adapted from:  https://stackoverflow.com/questions/47867949/how-can-i-check-for-a-pending-reboot
Adapted from:  https://gist.github.com/altrive/5329377
Based on:      https://github.com/bcwilhite/PendingReboot
Originally at: https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542

@author Dave Evans <https://github.com/stringydave>
@licence MIT
@version 0.0.1
#>

function Test-PendingRestart {
    if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { Write-Host "Component Based Servicing\RebootPending"; return $true }
    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { Write-Host "Auto Update\RebootRequired"; return $true }
    if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { Write-Host "PendingFileRenameOperations"; return $true }
    try { 
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        if (($status -ne $null) -and $status.RebootPending) {
            return $true
        }
    }
    catch { }

    return $false
}

$endresult = Test-PendingRestart
Write-Host "Pending Restart:",  $endresult

If ($endresult) {
    Exit 1
}