# -*- coding: utf-8 -*
'''
pip3 install -i https://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com/pypi/simple/ locust
运行: locust
输入：用户数，加速度，host就会开始测试
'''
from locust import HttpUser, task


class LocustTest(HttpUser):
    @task
    def nginxCall(self):
        self.client.get('http://139.180.204.36/poweredby.png')
