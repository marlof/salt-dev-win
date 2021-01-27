# Setup the solr cloud index
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr.zookeeper
# salt_minion_run:  salt-call --local state.apply solr.zookeeper

{% from "solr/map.jinja" import solr with context %}


solr_create_index:
  cmd.run:
    - name: echo Create a index directory
  file.directory:
    - name: {{solr.index_dir}}
    - makedirs: True
    

{% set solr_index_list =  ['solr.xml','zoo.cfg'] %}
{% for f in solr_index_list %}
solr_copy_config{{loop.index0}}:
  file.copy:
    - name:         "{{solr.index_dir}}{{f}}"
    - source:       salt://solr/files/{{f}}
{% endfor %}
