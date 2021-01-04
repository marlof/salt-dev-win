mssql-server:
  '2016':
    full_name: 'SQL Server Express 2016'
    installer: 'C:\salt\fake_repo\exes\SQLOffline\Setup.exe'
    uninstaller: 'C:\salt\fake_repo\exes\SQLOffline\Setup.exe'
    install_flags: '/QS /IACCEPTSQLSERVERLICENSETERMS /SQLSVCPASSWORD="somepassword" /ConfigurationFile=C:\salt\fake_repo\config\mssqltest2.ini'
    uninstall_flags: '/QS'
    msiexec: False
    locale: en_US
    reboot: False