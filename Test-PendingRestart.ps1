<#
Powershell script to return 1 if a Restart is Pending

Usage: Test-PendingRestart.ps1
return: 0   no Pending Restart detected
return: 1   Pending Restart detected

Adapted from: https://stackoverflow.com/questions/47867949/how-can-i-check-for-a-pending-reboot
Adapted from: https://gist.github.com/altrive/5329377
Based on:     https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542 which seems to have moved to: https://github.com/bcwilhite/PendingReboot

@author Dave Evans <https://github.com/stringydave>
@licence MIT
@version 0.0.1
#>

function Test-PendingReboot {
    if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { return $true }
    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { return $true }
    if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { return $true }
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

$endresult = Test-PendingReboot
Write-Host "Pending Rebbot:",  $endresult

If ($endresult) {
    Exit 1
}