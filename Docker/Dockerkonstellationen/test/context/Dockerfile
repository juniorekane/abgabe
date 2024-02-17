FROM debian:trixie

COPY sources.list /etc/apt/

RUN apt-get -y update && apt-get -y upgrade

# for non-interactive localization in debian/ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Berlin
RUN apt-get install -y tzdata
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# base packages
RUN apt-get -y install vim tree curl w3m ncat less procps dumb-init bat git bc
RUN apt-get -y install iproute2 net-tools iputils-ping
RUN apt-get -y install html2text
RUN apt-get -y install openssh-server sudo
RUN apt-get -y install apache2 php
RUN apt-get -y install bash-completion
RUN apt-get -y install locales
RUN apt-get -y install openjdk-21-jdk
RUN apt-get -y install redis redis-tools
RUN apt-get -y install mariadb-server
RUN apt-get -y install tcpdump 
# bat is batcat
RUN ln -s /usr/bin/batcat /usr/local/bin/bat


# install node
RUN apt-get -y install -y ca-certificates gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key |\
    gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" |\
    tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y

# set en as default locale
RUN sed  -i "s/^# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# wie versprochen - am Ende ...
RUN apt-get install -y jid jq jc
RUN apt-get install -y shfmt shellcheck
RUN apt-get install -y wrk imagemagick moreutils coreutils fonts-liberation
RUN apt-get install -y pwgen wget net-tools tcpdump bash-builtins bash-completion
RUN apt-get install -y openjdk-21-doc openjdk-21-source
RUN apt-get install -y ffmpeg mpv texlive-latex-extra
RUN apt-get install -y gron
RUN apt-get install -y build-essential
RUN apt-get install -y xmlstarlet man gcc-doc

RUN apt-get update && apt-get -y dist-upgrade

RUN mkdir /startup


# inject init script
COPY myinit.sh /usr/bin/

# install tomcat to opt
COPY opt/ /opt/
RUN groupadd -g 800 tomcat && useradd -u 800 -g 800 tomcat 
RUN chown -R tomcat:tomcat /opt/tomcat



# dumb-init as init process runs myinit.sh
ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]

