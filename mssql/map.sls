    {% if salt.grains.get('os_family') == 'Windows' %}
    - name: mssql-server      # Arguments
    - version: 2016
    {% elif salt.grains.get('os_family') == 'Linux' %}
    - name: mysql             # Arguments
    {% endif %}