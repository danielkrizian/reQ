# Internal Functions

## `.req.addcookie`

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