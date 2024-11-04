import os


class Config(object):
    print(os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static'))
    STATIC_FOLDER = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static')
    AUDIO_FOLDER = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static', 'audio')
