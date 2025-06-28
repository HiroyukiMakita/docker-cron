FROM debian:stable-slim

ARG TIMEZONE=${TIMEZONE}

RUN apt-get -y update && \
    apt-get -y install cron procps rsyslog systemctl less tzdata vim curl && \
    # date コマンドなどの実際のタイムゾーンは /etc/localtime を参照しており、TZ 環境変数には依存しないので
    # システム全体のタイムゾーン設定である /etc/localtime を正しいタイムゾーンに設定する必要がある
    ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./cron.d/ /etc/cron.d/
COPY ./startup.sh /etc/cron/startup.sh
COPY ./aliases.txt /etc/cron/aliases.txt
COPY ./logrotate/ /etc/logrotate.d/

RUN chmod -R 0644 /etc/cron.d/ && \
    chown -R root:root /etc/cron.d/ && \
    chmod 0744 /etc/cron/startup.sh && \
    mkdir -p /var/log/cron && \
    touch /var/log/cron/schedule.log && \
    touch /var/log/cron/schedule-error.log && \
    cat /etc/cron/aliases.txt >> ~/.bashrc && \
    touch /var/log/cron.log && \
    chmod 644 /var/log/cron.log && \
    chown root:root /var/log/cron.log && \
    echo "cron.*                                /var/log/cron.log" >> /etc/rsyslog.conf && \
    chmod -R 0644 /etc/logrotate.d/ && \
    chown -R root:root /etc/logrotate.d/

CMD ["/etc/cron/startup.sh"]