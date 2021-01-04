install_mssql:                # State ID.
  pkg.installed:              # Module.Function
    - name: mssql-server      # Arguments
    - version: 2016