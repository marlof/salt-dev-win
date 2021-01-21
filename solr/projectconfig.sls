# Configure the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr
# salt_minion_run:  salt-call --local state.apply solr.projectconfig

include:
  - solr.config
  - solr.changeheap
