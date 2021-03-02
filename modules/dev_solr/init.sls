################################################################
# Do not modify this header block
################################################################
# Use the PATH to find the sls name and module name
{% set sls_path = sls.split('.') %}
{% set sls_name = sls_path[-1] %}
{% set module_name = sls_path[1] %}
################################################################
# Import library functions
{% from 'modules/' + module_name + '/sls_bin/lib.sls' import LOG, MESSAGE, DEBUG,ERROR,WRITEFLAG, log_dir, run_dir %}
{% from 'modules/' + module_name + '/sls_bin/lib.sls' import debugMode with context %}
################################################################
# Check for debug flag
{% if debugMode == true %}
{{ LOG( sls_name, 'debug mode initiated.') }}
{% endif %}
################################################################
# Check module has already ran
{% if salt[ 'file.file_exists' ]('{{run_dir}}' + module_name + '/' + sls_name ) and ( debugMode == false ) %}
{{ MESSAGE( sls_name, 'module already ran.') }}
{{ LOG( sls_name, 'module already ran.') }}
################################################################
{% else %}
{{ LOG( sls_name, 'started.') }}
################################################################
# Set the OS check/break here
{% set tested_os={
  'OEL':
    {'cpuarch':'x86_64'},
  'Windows':
    {'osrelease':'2016Server'},
} %}

{% for ingredient,result in tested_os.iteritems() recursive %}
{{ ingredient }}:
  cmd.run: 
    - echo "in"
{% if result is mapping %}
{{ loop(result.iteritems()) }}: 
  cmd.run: 
    - echo "map"
{% else %} 
{{ingredient }}-{{ result }}:
  cmd.run:
    - echo "result"
{% endif %}</li>
{% endfor %}

{% if (grains['os'] == 'OEL') and (grains['cpuarch'] == 'x86_64') or ((grains['os'] == 'Windows') and (grains['osrelease'] >= "2018Server" )) %}
{{ DEBUG("OS  is " + grains['os']      ) }} 
{{ DEBUG("CPU is " + grains['cpuarch'] ) }}
{{ DEBUG("" + grains['osrelease'] + " >= 2016Server ") }}
{% else %}
{% if (grains['os'] == 'Windows') %}
{{ ERROR("Hostname is running Windows but not a high enough version") }}
{% else %}
hostname_is_not_running_OEL_or_is_not_an_x86_64:
  cmd.run:
    - name: "echo '---> Alert ! this hostname is not running Linux OEL or is not x86_64 arch, execution aborted !'"
{% endif %}
{% endif %}
{% endif %}
################################################################


# Main, place code here




{# start of main code ---------------------------------------------------------------------------
All functionality to be split up into submodules under sls_bin #}


{{ DEBUG("Running the include files....") }}
include:
  - modules.{{module_name}}.sls_bin.base
  - modules.{{module_name}}.sls_bin.install

{# end of main code -----------------------------------------------------------------------------#}



################################################################
# Mark that the run completed
{{ LOG( sls_name, 'stopped.') }}
{{ WRITEFLAG( sls_name ) }}
################################################################

