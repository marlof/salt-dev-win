#==============================================================================
# You may need to change the execution policy in order to run this script
# Run the following in powershell:
#
# Set-ExecutionPolicy RemoteSigned
#
#==============================================================================
#
#          FILE: install_salt.ps1
#
#   DESCRIPTION: Salt Installation for Windows
#       AUTHOR : Marc Loftus (webmarcit)
#       CREATED: 20210112
#==============================================================================

$saltversion = "Salt-Minion-3002.2-Py3-AMD64-Setup.exe"

$dir_source      = "https://repo.saltstack.com/windows/$saltversion"
$dir_destination = "c:\salt\exe\"
$destination     = "$dir_destination$saltversion"

$salt            = "C:\salt\salt-call.bat"
$testfile        = "C:\salt\uninst.exe"

clear
Write-Output "
Running $(ScriptName)...
=====================================================================================

  Download $dir_destination$saltversion


=====================================================================================

  $(ScriptName) - Salt Minion Installation
  $saltversion

=====================================================================================
"
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
  Write-Host "Downloading : $src"
  Write-Host "Target      : $dest"
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


#==============================================================================
# Download
#==============================================================================
  If (Test-Path $destination -PathType Leaf) {
    Write-Output "
      May already be downloaded.
      Check md5."
  } Else {
    GetUrl  $source $destination
    Write-Output "  $destination /S /master=localhost /minion-name=%COMPUTERNAME%"
  }


#==============================================================================
# Install
#==============================================================================
  If (Test-Path $testfile -PathType Leaf) {
    Write-Output "
      May already be installed.
      Check md5."
  } Else {
    iex "$destination /S /master=localhost /minion-name=marc-minion"
    Write-Host -NoNewline  "Installing..."
  }



} Else {
  Write-Output "You must be administrator to run this script."

}

  
while (!(Test-Path "$testfile")) { 
  Write-Host  -NoNewline "."
  Start-Sleep -Seconds 10
}




Write-Output "
=====================================================================================

 Salt Minion Installed

 It may take several minutes to complete.
 To confirm installtion run:

    $salt --version

 Missing options in c:\salt\conf\minion
  Add the following....
  x
  y
  z
=====================================================================================
"

iex "$salt --version"

#iex 'c:\temp\Salt-Minion-2015.5.0-AMD64-Setup.exe /S /master=salt-master /minion-name=$env:computername'
