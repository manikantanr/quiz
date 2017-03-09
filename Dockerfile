FROM ubuntu:16.04
RUN apt-get update && apt-get install -y supervisor \
    python-dev python python-pip \
    python-dev gcc git make \
    libssl-dev g++ libffi-dev \
    sqlite build-essential tcl curl wget

RUN mkdir -p /var/log/supervisor
ENV REDIS_URL redis://localhost:6379/0
COPY . .

RUN pip install --upgrade pip setuptools && pip install -r requirements.txt


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN cd /tmp && curl -O http://download.redis.io/redis-stable.tar.gz && \
    tar xzvf redis-stable.tar.gz && cd redis-stable && make && make install

EXPOSE 6379 80

CMD ["/usr/bin/supervisord"]