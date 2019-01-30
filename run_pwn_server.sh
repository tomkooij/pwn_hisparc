export PATH=$HOME/miniconda/bin:$PATH
export FLASK_APP=pwn_server.py
export FLASK_DEBUG=1
flask run --host=0.0.0.0 >>pwn_server.log 2>&1
