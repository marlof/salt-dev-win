# salt-dev-win

## Installation on windows server 2016 as serverless minion
Overview from: https://docs.saltstack.com/en/latest/topics/installation/windows.html
Download https://repo.saltstack.com/windows/Salt-Minion-3002.2-Py3-AMD64-Setup.exe
Run %HOME% / Downloads/Salt-Minion-3002.2-Py3-AMD64-Setup.exe






## Commands

Recent commands used

salt-call --local cmd.run $REPO'\'$MSSQL_VERSION' /ConfigurationFile='$DIR_CONFIG'\'$FILE_CONFIG'  /IAcceptSQLServerLicenseTerms'

salt-call cmd.run 'C:\salt\fake_repo\exes\SQLOffline\Setup.exe /QS /IACCEPTSQLSERVERLICENSETERMS /SQLSVCPASSWORD="changeme" /ConfigurationFile=C:\salt\fake_repo\config\mssqltest2.ini'

salt-call cmd.run template=jinja 'echo {{grains}}'

salt-call cmd.run template=jinja 'echo {{grains.id}}'

salt-call grains.get locale_info:defaultlanguage

salt-call grains.get locale_info

salt-call pkg.refresh_db

salt-call cp.list_master | more

salt-call state.sls mssql -l debug

salt-call saltutil.sync_all

salt-call sys.doc saltutil | more

salt-call sys.doc myutil

salt-call state.show_sls mssql

salt-call --local grains.items | more

salt-call network.netstat

salt-call network.ip_addrs

salt-call cmd.run 'dir'

salt-call myutil.somethingelse
