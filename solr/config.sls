# Set the colrconfig file
# <documentCache size initialSize and autowarmcount
# 
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.config


{% set solr_data=        salt['pillar.get']('solr:data',        "C:/solr/data") %}

{% set document_cache_size= salt['pillar.get']('solr:document_cache_size',        "4000000") %}
{% set document_cache_init= salt['pillar.get']('solr:document_cache_init',        "4000000") %}
{% set autowarm=            salt['pillar.get']('solr:document_cache_init',        "0") %}
{% set solr_user=           salt['pillar.get']('solr:user',                       "solr") %}



test_solrconfig_xml:
  cmd.run:
    - name: echo Configure the solrconfig.xml with document_cache_size {{document_cache_size}} and document_cache_init {{document_cache_init}} with autowarmCount {{autowarm}}

 
solr_xml:
  file.managed:
    - name: {{solr_data}}/solrconfig.xml
    - source: salt://solr/files/solrconfig.xml
    - user: {{solr_user}}
{% if grains['os'] != "Windows" %}
    - group: {{solr_user}}
    - mode: 0644
{% endif %}    


set_solr_xml:
  file.replace:
  - name: {{solr_data}}/solrconfig.xml
  - pattern: '<documentCache jinja>'
  - repl: '<documentCache class="solr.LRUCache" autowarmCount="{{autowarm}}" initialSize="{{document_cache_init}}" size="{{document_cache_size}}"/>'
