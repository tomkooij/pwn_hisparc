# PWN HiSPARC

Inject a custom update into an HiSPARC station (to regain OpenVPN connection).

This was used to update the `ca.crt` that expired April, 2018.

How to use:

Redirect traffic using `uwsgi.ini`:

```
route-remote-addr = ^1\.1\.1\.1$ redirect:http://pwn_server${REQUEST_URI}
```

Run the PWN server using the supplied script.
The payload is stored in `/static`
