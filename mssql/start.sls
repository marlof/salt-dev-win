start_mssql:
  service.running:
    - name: mssql-server
    - enable: True