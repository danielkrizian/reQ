# Internal Functions

*Warning: The functions documented here are internal functions used by the
library. While most of these are unlikely to change in usage in future versions
be aware this is possible and take care if using these functions directly*

---

#### `.req.addcookie[host;cookiestring]`

The function called internally when a `Set-Cookie` header is received on an
HTTP response, taking the host for the request & the cookie header string as
arguments.

```
q).req.addcookie["adventofcode.com";"session=n0tar34ls3ss10nc00k13"]
q).req.cookiejar
host               path name     | val                     expires maxage secure httponly samesite
---------------------------------| ---------------------------------------------------------------
"adventofcode.com" ,"*" "session"| "n0tar34ls3ss10nc00k13"                0      0
```