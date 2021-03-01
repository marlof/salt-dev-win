# Common macros

# Variabl assignment

# Audit
{% set b_debug = False %}


# Module and SLS
{% set dir_path   = sls.split('.') %}
{% set str_module = dir_path[1]    %}
{% set str_sls    = dir_path[-1]   %}




# LOG
# Usage: {#                {{ LOG( str_sls, "started."') }}          #}
{% macro LOG(str_sls, message) -%}
  file.append:
    - name: {{ dir_log }}/{{ str_module }}/{{ str_module }}.log
    - text: '{{ timestamp }} {{ str_sls }} {{ message}}'
{%- endmacro %}

# MESSAGE
# Usage: {#                {{ MESSAGE( sls_name, "started."') }}          #}
{% macro MESSAGE(str_sls, message) -%}
  cmd.run:
    - name: echo '{{ timestamp }} {{str_sls }} {{ message}}'
{%- endmacro %}

# VERBOSE
{% macro MESSAGE(str_sls, message) -%}
{% if b_debug == true %}
  cmd.run:
    - name: echo '{{ timestamp }} VERBOSE {{str_sls }} {{ message}}'
{% endif %}
{%- endmacro %}
