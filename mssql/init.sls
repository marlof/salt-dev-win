# Manage SQL Server 
# salt_master_test: null
# salt_minion_test: salt-call.bat state.show_sls mssql

include:
  - mssql.install
  - mssql.start
