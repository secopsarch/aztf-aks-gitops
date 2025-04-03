from flask import Flask, render_template, jsonify
from flask_cors import CORS
import socket
import platform
import os

app = Flask(__name__, 
    template_folder='../frontend/templates',
    static_folder='../frontend/static'
)
CORS(app)

def get_system_info():
    return {
        'hostname': socket.gethostname(),
        'ip': socket.gethostbyname(socket.gethostname()),
        'platform': platform.platform(),
        'python_version': platform.python_version(),
        'container_id': os.uname().nodename
    }

@app.route('/')
def index():
    system_info = get_system_info()
    return render_template('index.html', system_info=system_info)

@app.route('/health')
def health():
    return jsonify({
        'status': 'healthy',
        'container': get_system_info()
    })

@app.route('/api/info')
def info():
    return jsonify(get_system_info())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True) 