FROM alpine:3.5

MAINTAINER "Manikantan Ramachandran" <manikantanr@biarca.com>

WORKDIR /app

RUN apk upgrade --update-cache --available

RUN apk add python python-dev musl-dev py-virtualenv libffi-dev \
    openssl-dev file gcc ca-certificates && rm -rf /var/cache/apk/*

RUN pip install --upgrade pip

COPY . .

RUN pip install -r /app/requirements.txt

# check web scokets work with multi gunicorn workers
CMD gunicorn -w 3 -b 0.0.0.0:80 -k flask_sockets.worker --pythonpath=/app/ \
	--access-logfile=- --forwarded-allow-ips="*" quiz:app

EXPOSE 6379 80