# Test-PendingRestart
simple Powershell script to return 1 if a Restart is Pending

Usage: Test-PendingRestart.ps1
return: 0   no Pending Restart detected
return: 1   Pending Restart detected

I just wanted something simple which I could use in scripts running on workstaitons to tell if a Restart is Pending

There seem to be lots of scripts to query remote servers, but I could only find a few to just query the local machine

Adapted from: https://stackoverflow.com/questions/47867949/how-can-i-check-for-a-pending-reboot
which was adapted from: https://gist.github.com/altrive/5329377
which was based on:     https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542 
which seems to have moved to: https://github.com/bcwilhite/PendingReboot
