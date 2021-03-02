{# Header don't modify ! #}
{% set sls_path = sls.split('.') %}
{% set sls_name = sls_path[-1] %}
{% set module_name = sls_path[1] %}
{% from 'modules/' + module_name + '/sls_bin/lib.sls' import LOG, MESSAGE, DEBUG, log_dir, run_dir %}
{% from 'modules/' + module_name + '/sls_bin/lib.sls' import debugMode with context %}


{# Check module has already ran #}
{% if salt[ 'file.file_exists' ]( run_dir +'/' + module_name + '/' + sls_name ) and ( debugMode == false ) %}
{{ MESSAGE( sls_name, 'module already ran.') }}
{% else %}                                                                                     

{# Main code here #} 
{# Add ALL FUNCTIONALITY HERE#}

{# Create log directories:#}
_create_directory:
  file.directory:
    - names:
      - {{log_dir}}/{{module_name}}
      - {{run_dir}}/{{module_name}}
    - makedirs: True


{# Create log files #}
_create_logfiles:
  file.touch:
    - names:
      - {{log_dir}}/{{module_name}}/{{module_name}}.log

{# Write flag #}
{{run_dir}}/{{module_name}}/{{sls_name}}:
  file.touch
{%endif%}