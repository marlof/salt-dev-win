# Deploy the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr



{% set solr_ver=         salt['pillar.get']('solr:ver', "7.7.3") %}
{% set solr_name=        salt['pillar.get']('solr:name', "solr") %}
{% set solr_url=         salt['pillar.get']('solr:url', "https://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/solr/") %}
{% set solr_hash=        salt['pillar.get']('solr:url', "https://downloads.apache.org/lucene/") %}
{% set solr_install_dir= salt['pillar.get']('solr:install_dir', "C:/solr") %}

{% set solr_logs=        salt['pillar.get']('solr:logs', "{{solr_install_dir}}\logs") %}
{% set solr_data=        salt['pillar.get']('solr:data', "{{solr_install_dir}}\data") %}
{% set solr_home=        salt['pillar.get']('solr:home', "{{solr_install_dir}}") %}
{% set solr_user=        salt['pillar.get']('solr:user', "solr") %}
{% set solr_temp=        salt['pillar.get']('solr:user', "C:/temp") %}
{% set zoo_data=         salt['pillar.get']('solr:zoo_data', "/var/zookeeper/data") %}
{% set zoo_logs=         salt['pillar.get']('solr:zoo_logs', "/var/zookeeper/logs") %}


 
solr_get:
  # FIXME: Get the solr release from a location (This should be NEXUS)
  file.managed:
    - name:          {{solr_temp}}/{{solr_name}}-{{solr_ver}}.zip
    - source:        {{solr_url}}{{solr_ver}}/{{solr_name}}-{{solr_ver}}.zip
    - source_hash:   {{solr_hash}}/{{solr_name}}/{{solr_ver}}/{{solr_name}}-{{solr_ver}}.zip.sha512
    - if_missing:    {{solr_install_dir}}/{{solr_name}}-{{solr_ver}}/


solr_extract:
  archive.unzip:
    - name:  {{solr_temp}}/{{solr_name}}-{{solr_ver}}.zip
    - cwd:   {{solr_install_dir}}
