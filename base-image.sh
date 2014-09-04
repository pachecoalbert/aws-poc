#!/bin/bash

output : { all : '| tee -a /var/log/cloud-init-output.log' }

echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "BEGIN" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1

# Create Log direcotry
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Creating Log Directory" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
mkdir /home/ec2-user/logs
touch /home/ec2-user/logs/install.log
chown -R ec2-user:ec2-user /home/ec2-user/logs
chmod 775 /home/ec2-user/logs
chmod 666 /home/ec2-user/logs/install.log 

# Update All packages
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Updating all yum packages" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
yum -y update >>  /home/ec2-user/logs/install.log 2>&1

# Install Puppet
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Installing Puppet" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
yum -y install puppet.x86_64 >>  /home/ec2-user/logs/install.log 2>&1

# Install GIT
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Installing GIT" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
yum -y install git.x86_64 >>  /home/ec2-user/logs/install.log 2>&1

#
# List Installed Packages
#
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "List Installed Packages" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
yum list installed puppet git >>  /home/ec2-user/logs/install.log 2>&1

echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Download Server Config Puppet Manifests from github" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
cd /etc
mv puppet puppet.orig
git clone https://github.com/pachecoalbert/puppet.git >> /home/ec2-user/logs/install.log 2>&1

echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Issue Puppet Apply - Apache" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
puppet apply /etc/puppet/manifests/site.pp >> /home/ec2-user/logs/install.log 2>&1

echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "Download Application Code from github" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
mkdir /deployment
cd /deployment
git clone https://github.com/pachecoalbert/aws-poc.git >> /home/ec2-user/logs/install.log 2>&1

mv /var/www/html /var/www/html.orig
cp -r /deployment/aws-poc/html /var/www/
chmod 755 /var/www/html


echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1
echo "END" >> /home/ec2-user/logs/install.log 2>&1
echo "******************************************************************" >> /home/ec2-user/logs/install.log 2>&1

