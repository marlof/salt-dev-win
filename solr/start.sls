# Setup the solr cloud index
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.start
# salt_minion_run:  salt-call --local state.apply solr.start


{% set solr_install_dir=  salt['pillar.get']('solr:install_dir', "C:/solr") %}
{% set solr_index_dir=    salt['pillar.get']('solr:logs',        "C:/solr/index/") %}
{% set solr_port =        salt['pillar.get']('solr:port',        "8000") %}


solr_start:
  cmd.run:
    - name: echo Starting {{solr_install_dir}}/bin/solr.cmd on port {{solr_port}} try http://localhost:{{solr_port}}
    - name: {{solr_install_dir}}/bin/solr.cmd start -cloud -p {{solr_port}} -s {{solr_index_dir}}
