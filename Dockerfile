FROM debian:stable-slim

RUN apt-get -y update && \
    apt-get -y install cron procps rsyslog systemctl less tzdata vim && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./cron.d/ /etc/cron.d/
COPY ./startup.sh /etc/cron/startup.sh
COPY ./aliases.txt /etc/cron/aliases.txt

RUN chmod -R 0644 /etc/cron.d/ && \
    chown -R root /etc/cron.d/ && \
    chmod 0744 /etc/cron/startup.sh && \
    mkdir -p /var/log/cron && \
    touch /var/log/cron/schedule.log && \
    touch /var/log/cron/schedule-error.log && \
    cat /etc/cron/aliases.txt >> ~/.bashrc && \
    touch /var/log/cron.log && \
    chmod 644 /var/log/cron.log && \
    chown root:root /var/log/cron.log && \
    echo "cron.*                                /var/log/cron.log" >> /etc/rsyslog.conf

CMD ["/etc/cron/startup.sh"]