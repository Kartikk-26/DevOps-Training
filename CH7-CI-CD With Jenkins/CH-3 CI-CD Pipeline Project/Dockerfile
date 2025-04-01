FROM centos:8

RUN rm -f /etc/yum.repos.d/*

WORKDIR /etc/yum.repos.d

COPY ./local.repo /etc/yum.repos.d/

RUN yum install -y httpd zip wget

WORKDIR /var/www/html

RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page290/brainwave.zip

RUN unzip brainwave.zip

RUN rm -f brainwave.zip &&\
    cp -rf brainwave-html/* . &&\
        rm -rf brainwave-html
EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

