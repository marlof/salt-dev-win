# Query the solr cloud index status
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.status
# salt_minion_run:  salt-call --local state.apply solr.status


{% set solr_install_dir=  salt['pillar.get']('solr:install_dir', "C:/solr") %}


solr_start:
  cmd.run:
    - name: {{solr_install_dir}}/bin/solr.cmd status 
