# Setup the solr cloud index
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.zookeeper
# salt_minion_run:  salt-call --local state.apply solr.zookeeper


{% set solr_index_dir=    salt['pillar.get']('solr:logs',        "C:/solr/index/") %}
{% set solr_install_dir=  salt['pillar.get']('solr:install_dir', "C:/solr") %}
{% set solr_index_list =  ['solr.xml','zoo.cfg'] %}


solr_create_index:
  cmd.run:
    - name: echo Create a index directory
  file.directory:
    - name: {{solr_index_dir}}
    - makedirs: True


{% for f in solr_index_list %}
solr_copy_config{{loop.index0}}:
  file.copy:
    - name:         "{{solr_index_dir}}{{f}}"
    - source:       salt://solr/files/{{f}}
{% endfor %}
