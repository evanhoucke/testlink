FROM debian

MAINTAINER Emmanuel VANHOUCKE

RUN apt-get update -y && \
    apt-get install -y apache2 php5 wget php5-mysql

RUN echo "max_execution_time=3000\n" >> /etc/php5/apache2/php.ini && \
    echo "post_max_size = 200M\n" >> /etc/php5/apache2/php.ini && \
    echo "upload_max_filesize = 100M\n" >> /etc/php5/apache2/php.ini && \
    echo "memory_limit = 512M\n" >> /etc/php5/apache2/php.ini && \
    echo "file_uploads = On\n" >> /etc/php5/apache2/php.ini && \
    echo "session.gc_maxlifetime=60000" >> /etc/php5/apache2/php.ini

ENV MAJOR=1
ENV MINOR=9
ENV PATCH=3

RUN wget -q http://sourceforge.net/projects/testlink/files/TestLink%20${MAJOR}.${MINOR}/TestLink%20${MAJOR}.${MINOR}.${PATCH}/testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz/download -O testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz &&\
    tar zxvf testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz && \
    rm -rf /var/www/html && \
    mv testlink-${MAJOR}.${MINOR}.${PATCH} /var/www/html && \
    rm testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN mkdir -p /var/testlink/logs /var/testlink/upload_area

COPY config/config_db.inc.php /var/www/html
COPY https://github.com/techknowlogick/testlink-docker/blob/master/custom_config.inc.php /var/www/html

RUN chmod 777 -R /var/www/html && \
    chmod 777 -R /var/testlink/logs && \
    chmod 777 -R /var/testlink/upload_area

EXPOSE 80/tcp

CMD ["/usr/sbin/apache2","-D", "FOREGROUND"]

