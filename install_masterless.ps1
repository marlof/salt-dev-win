#==============================================================================
#
#          FILE: install_masterless.ps1
#
#   DESCRIPTION: Salt Installation for Windows
#       AUTHOR : Marc Loftus (webmarcit)
#       CREATED: 20210112
#==============================================================================

$saltversion = "Salt-Minion-3002.2-Py3-AMD64-Setup.exe"

$dir_source      = "https://repo.saltstack.com/windows/$saltversion"
$dir_destination = "c:\test\"
$destination     = "$dir_destination$saltversion"

clear
Write-Output "Running $(ScriptName)..."
Write-Output "====================================================================================="
Write-Output ""
Write-Output "  Download $dir_destination$saltversion"
Write-Output ""
Write-Output ""
Write-Output "====================================================================================="
Write-Output ""
Write-Output "  $(ScriptName) - Salt Minion Installation"
Write-Output "  $saltversion"
Write-Output ""
Write-Output "====================================================================================="
Write-Output ""


function PSCommandPath() { return $PSCommandPath; }
function ScriptName() { return $MyInvocation.ScriptName; }
function MyCommandName() { return $MyInvocation.MyCommand.Name; }
function MyCommandDefinition() {
    # Begin of MyCommandDefinition()
    # Note: ouput of this script shows the contents of this function, not the execution result
    return $MyInvocation.MyCommand.Definition;
    # End of MyCommandDefinition()
}
function MyInvocationPSCommandPath() { return $MyInvocation.PSCommandPath; }

#Write-Host "";
#Write-Host "PSVersion: $($PSVersionTable.PSVersion)";
#Write-Host "";
#Write-Host "`$PSCommandPath:";
#Write-Host " *   Direct: $PSCommandPath";
#Write-Host " * Function: $(ScriptName)";
#Write-Host "";
#Write-Host "`$MyInvocation.ScriptName:";
#Write-Host " *   Direct: $($MyInvocation.ScriptName)";
#Write-Host " * Function: $(ScriptName)";
#Write-Host "";
#Write-Host "`$MyInvocation.MyCommand.Name:";
#Write-Host " *   Direct: $($MyInvocation.MyCommand.Name)";
#Write-Host " * Function: $(MyCommandName)";
#Write-Host "";
#Write-Host "`$MyInvocation.MyCommand.Definition:";
#Write-Host " *   Direct: $($MyInvocation.MyCommand.Definition)";
#Write-Host " * Function: $(MyCommandDefinition)";


#==============================================================================
# Get the Directory of actual script
#==============================================================================
$script_path = dir "$($myInvocation.MyCommand.Definition)"
$script_path = $script_path.DirectoryName


Write-Output ""
Write-Output "====================================================================================="
Write-Output ""
Write-Output "  $(ScriptName) - Salt Minion Installation"
Write-Output ""
Write-Output "====================================================================================="
Write-Output ""


#==============================================================================
# Create a Folder Function
#==============================================================================
Function CreateFolder($path) {
  $global:foldPath = $null
  foreach($foldername in $path.split("\")) {
    $global:foldPath += ($foldername+"\")
    if (!(Test-Path $global:foldPath)){
      New-Item -ItemType Directory -Path $global:foldPath
      Write-Output "$global:foldPath Folder Created Successfully"
    }
  }
}


#==============================================================================
# Download from a URL to a destination file
#==============================================================================
Function GetUrl($src, $dest) { 
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Write-Host "Download: $src"
  Write-Host "Target: $dest"
   Invoke-WebRequest -Uri $src -OutFile $dest
}


#==============================================================================
# Check for Elevated Privileges
#==============================================================================
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
If (($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
  Write-Output "Administrator - Pass"
  # CheckPython py --version

  CreateFolder "$dir_destination"
  #Set-Location $dir_destination 

  GetUrl  $source $destination
  Write-Output "  $destination /master=localhost /minion-name=%COMPUTERNAME%"
  iex "$destination /master=localhost /minion-name=%COMPUTERNAME%"

} Else {
  Write-Output "You must be administrator to run this script."


}


#iex 'c:\temp\Salt-Minion-2015.5.0-AMD64-Setup.exe /S /master=salt-master /minion-name=$env:computername'
