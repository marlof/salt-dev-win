# Configure the solr APP into windows
# Pillar at the CLI
# Set the SOLR HEAP
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig


{% set solr_heap=        salt['pillar.get']('solr:heap',    "6g") %}




change_heap:
  cmd.run:
    - name: echo set SOLR_HEAP={{solr_heap}}
