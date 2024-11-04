import os

from flask import Flask, render_template, send_from_directory


def create_app(config):
    app = Flask(__name__)

    app.config.from_object(config)


    @app.route('/', methods=['GET'])
    def index():
        # List all files in the audio directory
        audio_files = os.listdir(app.config['AUDIO_FOLDER'])
        return render_template('index.html', audio_files=audio_files)

    @app.route('/audio/<filename>')
    def get_audio(filename):
        # Send the audio file to the client
        return send_from_directory(app.config['AUDIO_FOLDER'], filename)

    return app
