# Set the colrconfig file
# <documentCache size initialSize and autowarmcount
# 
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.config


{% set cache_size= salt['pillar.get']('solr:document_cache_size',        "4000000") %}
{% set cache_init= salt['pillar.get']('solr:document_cache_init',        "4000000") %}
{% set autowarm=   salt['pillar.get']('solr:document_cache_init',        "0") %}



solrconfig_xml:
  cmd.run:
    - name: echo Configure the solrconfig.xml with document_cache_size {{cache_size}} and document_cache_init {{cache_init}} with autowarmCount {{autowarm}}
