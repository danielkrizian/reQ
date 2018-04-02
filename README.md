# reQ

A WIP library for HTTP requests in KDB+/q

KDB+ has built in functions for HTTP requests such as `.Q.hg` (GET) and `.Q.hp`(POST). However, these functions are somewhat limited by several factors. For example, using these functions you cannot supply custom HTTP headers within the requests (for example, authorization tokens that are required by many APIs, a user agent etc.). In addition, in case of an HTTP redirect response, `.Q.hg`/`.Q.hp` will fail.

reQ is a library designed to overcome these limitations for basic HTTP queries. It allows specifying of custom headers where necessary, and also automatically follows HTTP redirects. In addition, in case of JSON response, this will be parsed to KDB+ object automatically.

## Usage

The two main entry point functions within the library are `.req.get` and `.req.post`, replacing `.Q.hg` and `.Q.hp` respectively.
Other functions are currently undocumented but will be documented in time.

### `.req.get`

Takes two args:
* URL (can be string, hsym or symbol)
* Dictionary of HTTP headers

### `.req.post`

Takes three args:
* URL (can be string, hsym or symbol)
* Dictionary of HTTP headers
* Payload (should be a string) -> where necessary, `Content-Type` should be set in header dict manually. `Content-Length` will be added automatically

## Examples

### Custom Headers

```
$ q req.q                                                                                                                            
KDB+ 3.5 2017.10.11 Copyright (C) 1993-2017 Kx Systems
l32/ 2()core 1945MB jonny grizzly 127.0.1.1 NONEXPIRE

q).Q.hg`:http://httpbin.org/headers
"{\n  \"headers\": {\n    \"Connection\": \"close\", \n    \"Host\": \"httpbin.org\"\n  }\n}\n"
q).req.get["http://httpbin.org/headers";`custom`headers!("with custom";"values")]
       | Accept Connection Custom        Headers  Host          User-Agent
-------| -----------------------------------------------------------------
headers| "*/*"  "close"    "with custom" "values" "httpbin.org" "kdb+/3.5"
```

### HTTP Redirect

```
$ q req.q                                                                                                                            
KDB+ 3.5 2017.10.11 Copyright (C) 1993-2017 Kx Systems
l32/ 2()core 1945MB jonny grizzly 127.0.1.1 NONEXPIRE

q).Q.hg`:http://httpbin.org/redirect/3
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">\n<title>Redirecting...</title>\n<h1>Redirecting...</h1>\n<p>You should be redirected automatica..
q).req.get["http://httpbin.org/redirect/3";()!()]
args   | (`symbol$())!()
headers| `Accept`Connection`Host`User-Agent!("*/*";"close";"httpbin.org";"kdb+/3.5")
origin | "146.199.80.196"
url    | "http://httpbin.org/get"
```

### POST request

```
q).req.post["http://httpbin.org/post";enlist["Content-Type"]!enlist .req.ty`json;.j.j (1#`text)!1#`hello]
args   | (`symbol$())!()
data   | "{\"text\":\"hello\"}"
files  | (`symbol$())!()
form   | (`symbol$())!()
headers| `Accept`Connection`Content-Length`Content-Type`Host`User-Agent!("*/*";"close";"16";"application/json";"httpbin.org";"kdb+/3.5")
json   | (,`text)!,"hello"
origin | "146.199.80.196"
url    | "http://httpbin.org/post"
```
