# Deploy the solr APP into windows
# Pillar at the CLI
# salt_minion_test: salt-call --local state.show_sls solr

include:
  - solr.install
  - solr.projectconfig

