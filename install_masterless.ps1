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
$install_dir     = "C:\salt"
$dir_destination = "$install_dir\exe\"
$destination     = "$dir_destination$saltversion"

$salt            = "$install_dir\salt-call.bat"
$testfile        = "$install_dir\uninst.exe"
$formulas_dir    = "$install_dir\srv\formulas"

$computername    = iex hostname

##################################################################################
# Library Functions Do Not Modify
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
# Create a Folder Function
function CreateFolder($path) {
  $global:foldPath = $null
  foreach($foldername in $path.split("\")) {
    $global:foldPath += ($foldername+"\")
    if (!(Test-Path $global:foldPath)){
      New-Item -ItemType Directory -Path $global:foldPath
      Write-Output "$global:foldPath Folder Created Successfully"
    }
  }
}
# Download from a URL to a destination file
function GetUrl($src, $dest) { 
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Write-Host "Downloading : $src"
  Write-Host "Target      : $dest"
  Invoke-WebRequest -Uri $src -OutFile $dest
}
##################################################################################


clear
Write-Output "
Running $(ScriptName)...
=====================================================================================

  $(ScriptName) - Salt Minion Installation
  $saltversion $computername

=====================================================================================
"


#==============================================================================
# Install
#==============================================================================
If (Test-Path $testfile -PathType Leaf) {
  Write-Output "
    May already be installed.
    Check md5.
"
} Else {


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


Write-Output "
=====================================================================================

  $(ScriptName) - Salt Minion Installation

=====================================================================================
"


#==============================================================================



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
      Check md5.
"
  } Else {
    GetUrl  $dir_source $destination
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
    Write-Host -NoNewline  "Installing..."
    iex "$destination /S /master=localhost /minion-name=$computername-minion"
  }



} Else {
  Write-Output "You must be administrator to run this script."

}

  
while (!(Test-Path "$testfile")) { 
  Write-Host  -NoNewline "."
  Start-Sleep -Seconds 2
}


#Start-Sleep -Seconds 5


Write-Output "
=====================================================================================

 Salt Minion Installed

 It may take several minutes to complete.
 To confirm installtion run:

    $salt --version

=====================================================================================
"
}
#start-Sleep -Seconds 5
iex "$salt --version"

Write-Output "
=====================================================================================

 Missing options in $install_dir\conf\minion
  Add the following....
  x
  y
  z
=====================================================================================
"

#Start-Sleep -Seconds 5

Write-Output "
=====================================================================================

 Running winrepo.update_git_repos

=====================================================================================
"
iex  "$salt --local winrepo.update_git_repos"
#iex 'c:\temp\Salt-Minion-2015.5.0-AMD64-Set"up.exe /S /master=salt-master /minion-name=$env:computername'

Write-Output "
=====================================================================================

    mkdir -p $install_dir\srv\formulas
    CreateFolder $formulas_dir

    cd /srv/formulas
    git clone https://github.com/marlof/solr-formula.git

## or

    mkdir -p /srv/formulas
    cd $formulas_dir
    wget https://github.com/marlof/solr-formula/archive/main.zip
    tar xf solr-formula-master.tar.gz

## Add the new directory to file_roots:
$install_dir
file_roots:
  base:
    - /srv/salt
    - /srv/formulas/solr
=====================================================================================
"
#  CreateFolder "$dir_destination"

# CreateFolder "$formulas_dir"
cd $install_dir\srv\salt
echo "git clone https://github.com/marlof/solr.git"
git clone https://github.com/marlof/solr.git
