# Start SQL Server
# salt_master_test: 
# salt_minion_test: salt-call.bat sys.show_sls mssql.start

# Variables - will be moved into pillar
{% set name = 'mssql-server' %}


start_mssql:                            # State ID.
  service.running:                      # Module.Function
    - name:    {{ name    | json() }}   # Arguments
    - enable: True                      # Arguments
