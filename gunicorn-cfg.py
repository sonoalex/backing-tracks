# gunicorn_config.py
bind = '0.0.0.0:8000'
workers = 3
worker_class = 'sync'
threads = 2
timeout = 30
graceful_timeout = 30
keepalive = 2
errorlog = '-'
accesslog = '-'
loglevel = 'info'
proc_name = 'backing_track_gunicorn'