#==============================================================================
# You may need to change the execution policy in order to run this script
# Run the following in powershell:
#
# Set-ExecutionPolicy RemoteSigned
#
#==============================================================================
#
#          FILE: install_Package.ps1
#
#   DESCRIPTION: Installation of package for Windows
#       AUTHOR : Marc Loftus (webmarcit)
#       CREATED: 20210115
#==============================================================================


#==============================================================================
#  Package details , name version extension and final naming structure
#==============================================================================
$PackageName      = "solr"
$PackageVersion   = "7.7.3"
$PackageExtension = "zip"
$Package          = "$PackageName-$PackageVersion.$PackageExtension"

#==============================================================================
# Package binary source location (WIP:nexus)
#==============================================================================
$dir_source       = "https://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/$PackageName/$PackageVersion/"
$source           = "$dir_source/$Package"

#==============================================================================
# Package install parent root directory
#==============================================================================
$InstallDirectory = "C:"

#==============================================================================
# Package extract directory for zips
#==============================================================================
$dir_extract  = "C:\temp\$PackageName"

#==============================================================================
# Final Executable and test file (these can be the same in some cases)
#==============================================================================
$exe              = "$InstallDirectory\$PackageName\bin\$PackageName.cmd"
$testfile         = "$InstallDirectory\$PackageName\bin\$PackageName.cmd"

#==============================================================================
# Location of temparory download files (sometimes makes sense to keep with exe)
#==============================================================================
$dir_destination  = "$InstallDirectory\$PackageName\$PackageExtension"
$dir_destination  = "C:\temp"
$destination      = "$dir_destination\$PackageName.$PackageExtension"






$computername    = iex hostname
clear
Write-Output "
Running $(ScriptName)...
=====================================================================================

  $(ScriptName) - $PackageName Installation for version $PackageVersion

  Steps on $computername
    Check permissions
    Download           $source 
    Templocation       $destination
    Extract to         $InstallDirectory\$PackageName
    Run                $exe

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
# Extract a zip file
#==============================================================================
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
  param([string]$zipfile, [string]$outpath)
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}


#==============================================================================
# Check for Elevated Privileges
#==============================================================================
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
If (($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
  Write-Output "
  Administrator - Pass
  "
  # CheckPython py --version

  CreateFolder "$dir_destination"
  #Set-Location $dir_destination 


#==============================================================================
# Download
#==============================================================================
Write-Host "Testing file $destination"
  If (Test-Path $destination -PathType Leaf) {
    Write-Output "
      May already be downloaded.
      Check md5.
"
  } Else {
    GetUrl  "$source" "$destination"
    Write-Output "  $destination /S /master=localhost /minion-name=%COMPUTERNAME%"
  }


#==============================================================================
# Extract
#==============================================================================
Write-Host "Testing directory $dir_destination\$PackageName"
  If (Test-Path "$dir_destination\$PackageName") {
    Write-Output "
      May already be extracted.
      Check md5."
  } Else {
    Write-Host -NoNewline  "Extracting $destination to $InstallDirectory ... <ctrl c>"
    Start-Sleep -Seconds 2
    Unzip "$destination" "$dir_extract"
  }


#==============================================================================
# Install (sometimes just a move if extracted)
#==============================================================================
Write-Host "Testing file $exe"
  If (Test-Path $exe -PathType Leaf) {
    Write-Output "
      May already be installed.
      Check md5."
  } Else {
    Write-Host -NoNewline  "Move $dir_extract\$PackageName-$PackageVersion $InstallDirectory\
Move-Item -Path $dir_extract\$PackageName-$PackageVersion -Destination $InstallDirectory\
    "
    Start-Sleep -Seconds 2
    Move-Item -Path "$dir_extract\$PackageName-$PackageVersion" -Destination "$InstallDirectory\$PackageName"
  }


} Else {
  Write-Output "You must be administrator to run this script."

}

  
while (!(Test-Path "$testfile")) { 
  Write-Host  -NoNewline "."
  Start-Sleep -Seconds 2
}



Write-Output "
=====================================================================================

 Solr Installed
"
}

Write-Output "
=====================================================================================

 Confirm Java installed

  due to winrepo installer limitations you need to manually download the exe from
  # http://www.java.com/en/download/manual.jsp
  # and put it on the winrepo on master to install it the 'salt://win/repo-ng/jre8_*/...
  # https://javadl.oracle.com/webapps/download/AutoDL?BundleId=243737_61ae65e088624f5aaa0b1d2d801acb16
  salt-call pkg.install jre8
"


Write-Output "
=====================================================================================

  Test with $exe
"
iex "$exe"






#iex 'c:\temp\Salt-Minion-2015.5.0-AMD64-Setup.exe /S /master=salt-master /minion-name=$env:computername'
# Rename-Item -Path "c:\logfiles\daily_file.txt" -NewName "monday_file.txt"
