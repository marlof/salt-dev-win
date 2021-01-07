# Install SQL Server
# salt_master_test: 
# salt_minion_test: salt-call state.show_sls mssql

# Variables - will be moved into pillar
{% set name = 'mssql-server' %}
{% set version = 2016 %}


install_mssql:                          # State ID.
  pkg.installed:                        # Module.Function
    - name:    {{ name    | json() }}   # Arguments
    - version: {{ version | json() }}   # Arguments
