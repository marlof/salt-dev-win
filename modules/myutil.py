"""
Module to expand and do SQL Server Stuff with examples

:depends:    - SQLServer items

.. note::
     This is a note

:configuration: In order to connect to SQLServer, certain configurations is required
     in /srv/salt/minion on the relevant minio. Example config might look like::

       mssql.host: 'localhost'
       mmsql.port: 1433
       mssql.user: sqluser
       mssql.pass: ''
       mssql.db: 'mydb'
       mssql.charset: 'utf8'

.. versionchanged:: 2020.12.0
     \'charset\' connection added for a project

"""
def something():
  """
  Just to prove it works
  """
  return 'something happened'
