@echo off
REM User update v16
REM Replace old datastore URL upload.nikhef.nl 
REM updates user version to 16
REM
if not defined HISPARC_ROOT (
  echo HISPARC_ROOT not set. Guessing...
  set HISPARC_ROOT="C:\Program Files\HiSPARC\hisparc\"
)
echo HiSPARC software should be in: %HISPARC_ROOT%
REM
REM Write python script that will do the work
REM
echo Writing python helper script
@echo off
echo # generated by py2bat > update16.py
echo import re, os >> update16.py
echo # >> update16.py
echo # If HISPARC_ROOT not set, perhaps we are in %HISPARC_ROOT%\user\updater: >> update16.py
echo HISPARC_ROOT = os.environ.get^('HISPARC_ROOT', '..\\..'^) >> update16.py
echo # >> update16.py
echo HISPARC_CONFIG_INI = HISPARC_ROOT + '\\persistent\\configuration\\config.ini' >> update16.py
echo HSMONITOR_CONFIG = HISPARC_ROOT + '\\user\\hsmonitor\\data\\config.ini' >> update16.py
echo # >> update16.py
echo # set version number to 16 >> update16.py
echo with open^(HISPARC_CONFIG_INI, 'r'^) as infile: >> update16.py
echo     lines = infile.readlines^(^) >> update16.py
echo with open^(HISPARC_CONFIG_INI, 'w'^) as outfile: >> update16.py
echo     for line in lines: >> update16.py
echo         if "currentuser" in line.lower^(^): >> update16.py
echo             # replace version number >> update16.py
echo             line = re.sub^(r'\d+', '16', line^) >> update16.py
echo         outfile.write^(line^) >> update16.py
echo # >> update16.py
echo # change upload URL from frome.nikhef.nl to upload.hisparc.nl >> update16.py
echo with open^(HSMONITOR_CONFIG, 'r'^) as infile: >> update16.py
echo     lines = infile.readlines^(^) >> update16.py
echo with open^(HSMONITOR_CONFIG, 'w'^) as outfile: >> update16.py
echo     for line in lines: >> update16.py
echo         line = line.replace^('http://frome.nikhef.nl', 'https://upload.hisparc.nl'^) >> update16.py
echo         outfile.write^(line^) >> update16.py
echo
echo Run python helper script
python update16.py
echo Done!
