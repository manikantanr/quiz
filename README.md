# start redis

docker run --name some-redis -d redis

# start flask app container
$ docker run --name stack --link some-redis:redis -p 80:80 -d stack
