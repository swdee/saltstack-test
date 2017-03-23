logger:
  file.managed:
    - name: /root/logger.sh
    - source: salt://logger/logger.sh
    - mode: 750
    - user: root
    - group: root
  cron.present:
    - user: root
    - minute: '*/30'
    - name: '/root/logger.sh'
    - identifier: 'salttest-logger-script'

