# Configure the solr index in windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.zookeeper

{% set zoo_data= salt['pillar.get']('solr:zoo_data', "c:/zookeeper/data/") %}
{% set zoo_logs= salt['pillar.get']('solr:zoo_logs', "c:/zookeeper/logs/") %}
{% set zoo_url= salt['pillar.get']('solr:zoo_url', "http://www.eu.apache.org/dist/zookeeper/") %}
{% set zoo_ver= salt['pillar.get']('solr:zoo_ver', "3.4.7") %}
{% set zoo_name= salt['pillar.get']('solr:zoo_name', "zookeeper") %}
{% set zoo_conf_dir= salt['pillar.get']('solr:zoo_conf_dir', "c:/zookeeper/conf/") %}
{% set zk1= salt['pillar.get']('solr:zoo_cluster:servers:zk1:ip', '') %}
{% set zk2= salt['pillar.get']('solr:zoo_cluster:servers:zk2:ip', '') %}
{% set zk3= salt['pillar.get']('solr:zoo_cluster:servers:zk3:ip', '') %}
{% set zk1_id= salt['pillar.get']('solr:zoo_cluster:servers:zk1:id', '') %}
{% set zk2_id= salt['pillar.get']('solr:zoo_cluster:servers:zk2:id', '') %}
{% set zk3_id= salt['pillar.get']('solr:zoo_cluster:servers:zk3:id', '') %}
{% set host_ip = salt['grains.get']('ipv4')[1] %}


zookeeper:
  cmd.run:
    - name: echo {{zoo_data}}
