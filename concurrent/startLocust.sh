systemctl stop firewalld.service
yum remove python3 -y
yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel -y
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
tar -zxvf Python-3.7.0.tgz
cd Python-3.7.0
./configure prefix=/usr/local/python3 
make && make install
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3
pip3 install --upgrade pip
pip3 install locust