# Configure the solr APP into windows
# Pillar at the CLI
# Set the SOLR HEAP
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig


{% set solr_install_dir= salt['pillar.get']('solr:install_dir', "C:/solr") %}

{% set heap=      salt['pillar.get']('solr:heap',    "6g") %}
{% set java_mem=  salt['pillar.get']('solr:java_mem',"6g") %}


change_heap:
  cmd.run:
    - name: echo set SOLR_HEAP={{heap}} and JAVA MEM of {{java_mem}}

set_solr_heap:
  file.replace:
  - name:    {{solr_install_dir}}/bin/solr.cmd
  - pattern: 'set SOLR_HEAP=%~2'
  - repl:    'set SOLR_HEAP={{heap}}'

set_solr_java:
  file.replace:
  - name:    {{solr_install_dir}}/bin/solr.cmd
  - pattern: 'SOLR_JAVA_MEM=-Xms512m -Xmx512m'
  - repl:    'SOLR_JAVA_MEM=-Xms{{java_mem}} -Xmx{{java_mem}}'

