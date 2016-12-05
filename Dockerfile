FROM debian

MAINTAINER Emmanuel VANHOUCKE

ENV MAJOR=1
ENV MINOR=9
ENV PATCH=3

RUN apt-get update -y && \
    apt-get install -y apache2 php5 wget php5-mysql

RUN wget -q http://sourceforge.net/projects/testlink/files/TestLink%20${MAJOR}.${MINOR}/TestLink%20${MAJOR}.${MINOR}.${PATCH}/testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz/download -O testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz &&\
    tar zxvf testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz && \
    mv testlink-${MAJOR}.${MINOR}.${PATCH} /var/www/html/testlink && \
    rm testlink-${MAJOR}.${MINOR}.${PATCH}.tar.gz

RUN echo "max_execution_time=3000" >> /etc/php5/apache2/php.ini && \
    echo "session.gc_maxlifetime=60000" >> /etc/php5/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN mkdir -p /var/testlink/logs /var/testlink/upload_area

RUN chmod 777 -R /var/www/html/testlink && \
    chmod 777 -R /var/testlink/logs && \
    chmod 777 -R /var/testlink/upload_area

EXPOSE 80/tcp

CMD ["/usr/sbin/apache2","-D", "FOREGROUND"]

