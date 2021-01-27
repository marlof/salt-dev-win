# Configure the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig

{% from "solr/map.jinja" import solr with context %}

include:
  - solr.config
  - solr.changeheap

project_solr_check_version:
  cmd.run:
    - name: {{solr.install_dir}}/bin/solr.cmd version
