#!/bin/bash
setenforce 0 && \
getenforce && \
yum install -y -q \
    epel-release && \
yum update -y -q && \
yum install -y -q \
     wget \ 
     ncdu \
     tree \
     vnstat \
     htop \
     unzip \
     curl \
     git &&\
curl -fsSL https://get.docker.com -o get-docker.sh && \
      sh get-docker.sh &&\
curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose &&\
timedatectl set-timezone Asia/Tokyo&&\
systemctl start docker && \
systemctl enable docker &&\
firewall-cmd --permanent --zone=public --add-port=2233/tcp &&\
firewall-cmd --reload &&\
yum install fail2ban fail2ban-systemd whois -y -q

echo '
#!/bin/bash 

# get latest docker compose released tag 
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4) 

# Install docker-compose 
sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose" 
chmod +x /usr/local/bin/docker-compose 
sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose" 

# Output compose version 
docker-compose -v 

exit 0' > docker-compose-latest
chmod +x docker-compose-latest&& \
./docker-compose-latest


