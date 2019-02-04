# Resource Server for MITS

[![pipeline status](http://tabeldata.ip-dynamic.com:10/mandiri.co.id/mits-api-registration/badges/master/pipeline.svg)](http://tabeldata.ip-dynamic.com:10/mandiri.co.id/mits-api-registration/commits/master)

Aplikasi Resource (API) untuk MITS, menggunakan grant type client

## Access token 

```bash
curl -X POST -vu mandiri_mits:123456 http://localhost:10000/oauth/token -H "Accept: application/json" -d "client_id=mandiri_mits&grant_type=password&username=user&password=password" 
```

berikut hasilnya: 

```bash 
Note: Unnecessary use of -X or --request, POST is already inferred.
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 10000 (#0)
* Server auth using Basic with user 'mandiri_mits'
> POST /oauth/token HTTP/1.1
> Host: localhost:10000
> Authorization: Basic bWFuZGlyaV9taXRzOjEyMzQ1Ng==
> User-Agent: curl/7.54.0
> Accept: application/json
> Content-Length: 74
> Content-Type: application/x-www-form-urlencoded
> 
* upload completely sent off: 74 out of 74 bytes
< HTTP/1.1 200 
< Cache-Control: no-store
< Pragma: no-cache
< X-Content-Type-Options: nosniff
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: DENY
< Content-Type: application/json;charset=UTF-8
< Transfer-Encoding: chunked
< Date: Mon, 30 Apr 2018 06:55:08 GMT
< 
* Connection #0 to host localhost left intact
{"access_token":"49bf9b0b-5208-4c09-9890-a70b400ee56f","token_type":"bearer","refresh_token":"ca75351d-c63f-4d28-a210-a1d68ffd6a17","expires_in":43199,"scope":"read write trust"}%
```

## Akes Resource by access_token

```bash
 curl -H "Authorization: Bearer 49bf9b0b-5208-4c09-9890-a70b400ee56f" http://localhost:10001/api/user
```

berikut hasilnya:

```json
{
  "access" : 1525071422508,
  "username" : "user"
}
```


