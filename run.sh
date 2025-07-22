socat tcp-listen:8001,bind=0.0.0.0,fork,reuseaddr 'exec:bash -c ./serve.sh'
