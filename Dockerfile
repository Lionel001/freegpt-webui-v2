FROM python:3.10-slim-buster  
  
WORKDIR /app  
  
COPY requirements.txt requirements.txt  
  
RUN python -m venv venv  
ENV PATH="/app/venv/bin:$PATH" 


# MAINTAINER itdream "itdream6@163.com"
# RUN  sed -i 's@/archive.ubuntu.com/@/mirrors.aliyun.com/@g' /etc/apt/sources.list
# RUN  apt-get clean
# RUN apt-get update

# RUN  cp /etc/apt/sources.list /etc/apt/sources.list.bak
# RUN  nano /etc/apt/sources.list
# RUN deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# RUN deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free

# RUN deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main
# RUN deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main

# RUN deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# RUN deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free

# 替换默认的源为清华大学的源
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get update 
RUN apt-get install -y --no-install-recommends build-essential libffi-dev cmake libcurl4-openssl-dev

RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
RUN chmod -R 777 translations  
  
CMD ["python3", "./run.py"]  
