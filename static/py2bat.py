import sys

OUTFILE = 'update16.py'
print(f'echo # generated by py2bat > {OUTFILE}')
for line in sys.stdin:
    line = line.rstrip("\r").rstrip("\n")
    line = line.replace("(","^(").replace(")","^)").replace(">", "^>")
    if line.replace(' ', '') == '':   # empty line
        line = '#'  
    print(f'echo {line} >> {OUTFILE}')
