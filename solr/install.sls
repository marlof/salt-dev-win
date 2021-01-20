# Deploy the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr


{% set solr_ver=         salt['pillar.get']('solr:ver',         "7.7.3") %}
{% set solr_name=        salt['pillar.get']('solr:name',        "solr") %}
{% set solr_url=         salt['pillar.get']('solr:url',         "https://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/solr/") %}
{% set solr_hash=        salt['pillar.get']('solr:url',         "45461fb86851f8615f02dbc89a942facdd13ab9ca0d984eaf35ec1ed2cef653af738320945749c3130d27d5581a1f0ede34bdaf1ca9afbd4f9a631432d6ada58") %}
{% set solr_install_dir= salt['pillar.get']('solr:install_dir', "C:/solr") %}

{% set solr_logs=        salt['pillar.get']('solr:logs',        "C:/solr/logs") %}
{% set solr_data=        salt['pillar.get']('solr:data',        "C:/solr/data") %}
{% set solr_home=        salt['pillar.get']('solr:home',        "C:/solr") %}
{% set solr_user=        salt['pillar.get']('solr:user',        "solr") %}
{% set solr_temp=        salt['pillar.get']('solr:user',        "C:/temp") %}


solr_temp_dir:
  file.directory:
    - name: {{solr_temp}}
    - makedirs: True
 

solr_extract:
  archive.extracted:
    - name:         "{{solr_temp}}"
    - source:       "{{solr_url}}{{solr_ver}}/{{solr_name}}-{{solr_ver}}.zip"
    - source_hash:  "{{solr_hash}}"


solr_rename_extracted:
  file.rename:
    - name:         "{{solr_install_dir}}"
    - source:       "{{solr_temp}}/{{solr_name}}-{{solr_ver}}"
    - force:        True


{% set solr_dir_list = [solr_home,solr_logs,solr_data] %}
{% for d in solr_dir_list %}
solr_create_dirs{{loop.index0}}:
  file.directory:
    - name: {{d}}
    - makedirs: True
{% endfor %}


solr_check_version:
  cmd.run:
    - name: {{solr_install_dir}}/bin/solr.cmd version

