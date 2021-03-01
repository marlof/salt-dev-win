# salt-dev-win

## Installation on windows server 2016 as serverless minion
Overview from: https://docs.saltstack.com/en/latest/topics/installation/windows.html
Download https://repo.saltstack.com/windows/Salt-Minion-3002.2-Py3-AMD64-Setup.exe
Run %HOME% / Downloads/Salt-Minion-3002.2-Py3-AMD64-Setup.exe


# Clean slate

remove c:\solr, remove c:\salt, run salt.ps1

clone solr

run salt-call solr

salt-call --local state.apply solr 


# INSTALL
name:        'solr'
install_dir: 'c:/solr'
ver:         '7.7.3'
url:         'https://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/solr/'
hash:        '45461fb86851f8615f02dbc89a942facdd13ab9ca0d984eaf35ec1ed2cef653af738320945749c3130d27d5581a1f0ede34bdaf1ca9afbd4f9a631432d6ada58'
logs:        'C:/solr/logs'
data:        'C:/solr/data'
home:        'C:/solr'
user:        'solr'
temp:        'C:/temp'


# Memory Tweaks
heap:        '6g'
java_mem:    '6g'

# Solrconfig
document_cache_init: 400000
document_cache_size: 400000
autowarm:    0

# Zookeeper
port:        8993
index:       'c:/solr/node1'
node1:       'node1'



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

salt-call saltutil.clear_cache

salt-call sys.doc saltutil | more

salt-call sys.doc myutil

salt-call state.show_sls mssql

salt-call --local grains.items | more

salt-call network.netstat

salt-call network.ip_addrs

salt-call cmd.run 'dir'

salt-call myutil.somethingelse
