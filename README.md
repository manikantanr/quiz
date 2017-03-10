# start redis

docker run --name some-redis -d redis

# start flask app container
docker run --name stack --link some-redis:redis -p 80:80 -d stack

#run app locally
gunicorn -w 3 -b 0.0.0.0:80 -k flask_sockets.worker --access-logfile=- --forwarded-allow-ips="*" quiz:app


# run wifi kde-nm-connection-editor

