@echo off
REM replace the expired ca.crt by a new one
REM
REM This batchfile file echo's the crt (below) into a file
REM `new_cert.crt` in the current folder.
REM It subsequently copies it into the folder specified
REM below:
if not defined HISPARC_ROOT (
  echo HISPARC_ROOT not set. Trying relative path.
  set HISPARC_ROOT=..\..\
)
echo HiSPARC software should be in: %HISPARC_ROOT%
echo We will try both admin v6/v7 and v9 openvpn locations
SET openvpn_x64_location=\admin\openvpn64\config\
SET openvpn_x32_location=\admin\openvpn32\config\
SET openvpn_x64_location_v9=\admin\openvpn\x64\config\
SET openvpn_x32_location_v9=\admin\openvpn\x32\config\
REM
REM create `new_cert.crt`
REM This certificate is NOT secret
REM
echo Writing certificate to local folder
(echo -----BEGIN CERTIFICATE-----
echo MIIEtTCCA52gAwIBAgIJAMW2050JiGatMA0GCSqGSIb3DQEBBQUAMIGXMQswCQYD
echo VQQGEwJOTDELMAkGA1UECBMCTkgxEjAQBgNVBAcTCUFtc3RlcmRhbTEYMBYGA1UE
echo ChMPSGlTUEFSQywgTmlraGVmMRAwDgYDVQQLEwdIaVNQQVJDMRkwFwYDVQQDExB0
echo aWV0YXIubmlraGVmLm5sMSAwHgYJKoZIhvcNAQkBFhFoaXNwYXJjQG5pa2hlZi5u
echo bDAgFw0xODAzMDExODQyNDJaGA8yMTE4MDIwNTE4NDI0MlowgZcxCzAJBgNVBAYT
echo Ak5MMQswCQYDVQQIEwJOSDESMBAGA1UEBxMJQW1zdGVyZGFtMRgwFgYDVQQKEw9I
echo aVNQQVJDLCBOaWtoZWYxEDAOBgNVBAsTB0hpU1BBUkMxGTAXBgNVBAMTEHRpZXRh
echo ci5uaWtoZWYubmwxIDAeBgkqhkiG9w0BCQEWEWhpc3BhcmNAbmlraGVmLm5sMIIB
echo IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0dYabrSl3aIcgFCE8p2Sz/jv
echo xlavYjD6UXEcr4HNf1T5qkAqV1UCy189dPe9Heiu//awUPla0ZNtpY4g2SQ/H/+9
echo SskUQnBfReSbuyYC3MvANM6KFLzV3ufjCwTgo2ivyTgTm+rah+fmiTWQco2Jtu2J
echo 2HthHuMo7cBdMn0Asy51CZbLTL118qee9CIhRsNupPzn9ZHqhba8AItutmEQOMGd
echo lNutu0HLoQ4r1xBQ2TCzCToPCO30s1H/jsQ+0Tw6uK8bYDf0IByoHUNRzxSoXSJ8
echo PYJ4UQvWKV6ZTzf6zB3KpEXm6hHKpC3pmHVJ79zY8LVpbgQD0wlRmlDq1KGHKwID
echo AQABo4H/MIH8MB0GA1UdDgQWBBSrw0cU0u6bG+bj3E9ZcJVVxgZy8TCBzAYDVR0j
echo BIHEMIHBgBSrw0cU0u6bG+bj3E9ZcJVVxgZy8aGBnaSBmjCBlzELMAkGA1UEBhMC
echo TkwxCzAJBgNVBAgTAk5IMRIwEAYDVQQHEwlBbXN0ZXJkYW0xGDAWBgNVBAoTD0hp
echo U1BBUkMsIE5pa2hlZjEQMA4GA1UECxMHSGlTUEFSQzEZMBcGA1UEAxMQdGlldGFy
echo Lm5pa2hlZi5ubDEgMB4GCSqGSIb3DQEJARYRaGlzcGFyY0BuaWtoZWYubmyCCQDF
echo ttOdCYhmrTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUAA4IBAQB7mHTcJ6ww
echo GR1IXR+Q2aZmOv2LJtdJwrN/4t0JhVHJA+5Mr0T3N1YZ8il1x0CQyBRsAvTc4BCY
echo h2ueVbLXbM6crd8PYLFJg7JBOZcqPeaVVwWoN50LwzT+Qmo87R4RvRfYfJLzxweP
echo daO2/vk/8h2krWdw7Qa9L/4dW4FZGQ2rcySTyisNWcSxRWf1f74H/2UGRuAixjPQ
echo r20AhP2YhTQnPbUwPYsswckxgwz8lBWBL6N1RA0jWMYvG8hYz+4/BaicxbNKK9Wv
echo OJmZ0uC1Wko7qVpdRUYEQhQ67F/HRBfRndSrxCPlDIKBdzua/jInB5bVtwN4c2cy
echo sLrBY/zZaBrq
echo -----END CERTIFICATE-----
)>new_cert.crt
echo
echo Copying files
copy /Y new_cert.crt "%HISPARC_ROOT%\%openvpn_x32_location%\ca.crt"
copy /Y new_cert.crt "%HISPARC_ROOT%\%openvpn_x64_location%\ca.crt"
copy /Y new_cert.crt "%HISPARC_ROOT%\%openvpn_x32_location_v9%\ca.crt"
copy /Y new_cert.crt "%HISPARC_ROOT%\%openvpn_x64_location_v9%\ca.crt"
echo WARNING!! WE WILL REBOOT IN ABOUT 20 SECONDS!
REM below is just a hack to pause 20 seconds
ping -n 20 127.0.0.1 >nul
shutdown /r /f
