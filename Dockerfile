FROM centos:7

EXPOSE 8080

RUN yum -y update && \
    yum -y install epel-release && \
    rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum -y install git par2cmdline python-yenc python-cheetah unrar python-pip && \
    yum clean all && \
    rm -rf /var/cache/yum/ && \
    pip install --upgrade pip && \
    pip install sabyenc --upgrade && \
    useradd -m -G users -s /bin/bash sabnzbd && \
    mkdir /opt/sabnzbd && \
    chown -R sabnzbd:users /opt/sabnzbd

USER sabnzbd

RUN git clone https://github.com/sabnzbd/sabnzbd /opt/sabnzbd && \
    mkdir -p /home/sabnzbd/config

CMD /usr/bin/python /opt/sabnzbd/SABnzbd.py --config-file=/home/sabnzbd/config/sab_config.ini -s 0.0.0.0
