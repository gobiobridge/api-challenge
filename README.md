The Challenge
=============

The challenge, if you choose to accept it, is to create a small service to shorten urls, in the style that TinyURL and bit.ly made popular.

## Rules

1. The service must expose HTTP endpoints according to the definition below.
2. The service must be self contained, you can use any language and technology you like, but it must be possible to set it up from a fresh install of Debian or Debian-like server, and steps should be writen in the README.
3. Tests must be included.
4. The service must be versioned using git and submitted by making a Pull Request against this repository, git history **should** be meaningful.

## Tips

* Less is more, small is beautiful, you know the drill — stick to the requirements.
* No need to take care of domains, that's for a reverse proxy to handle.

**Good Luck!** — not that you need any ;)

-------------------------------------------------------------------------

## API Documentation

**All responses must be encoded in JSON and have the appropriate Content-Type header**


### POST /shorten

```
POST /shorten
Content-Type: "application/json"

{
  "url": "http://example.com",
  "short_code": "example"
}
```

Attribute | Description
--------- | -----------
**url**   | url to shorten
short_code | preferential shortcode

##### Returns:

```
201 Created
Content-Type: "application/json"

{
  "short_code": :shortcode
}
```

A random short code is generated if none is requested, the generated short code has exactly 6 alpahnumeric characters and passes the following regexp: ```^[0-9a-zA-Z_]{6}$```.

##### Errors:

Error | Description
----- | ------------
400   | ```url``` is not present
409   | The the desired short code is already in use. **Codes are case-sensitive**.
422   | The shor tcode fails to meet the following regexp: ```^[0-9a-zA-Z_]{4,}$```.


### GET /:code

```
GET /:code
Content-Type: "application/json"
```

Attribute       | Description
--------------- | -----------
**short_code**  | url encoded short code

##### Returns

**302** response with the location header pointing to the shortened URL

```
HTTP/1.1 302 Found
Location: http://www.example.com
```

##### Errors

Error | Description
----- | ------------
404   | The ```short code``` cannot be found in the system

### GET /:code/stats

```
GET /:code
Content-Type: "application/json"
```

Attribute      | Description
-------------- | -----------
**short_code**  | url encoded shortcode

##### Returns

```
200 OK
Content-Type: "application/json"

{
  "start_date": "2012-04-23T18:25:43.511Z",
  "last_seen_date": "2012-04-23T18:25:43.511Z",
  "redirect_count": 1
}
```

Attribute          | Description
---------------    | -----------
**start_date**     | date when the url was encoded, conformant to [ISO8601](http://en.wikipedia.org/wiki/ISO_8601)
**redirect_count** | number of times the endpoint ```GET /code``` was called
last_seen_date     | date of the last time the a redirect was issued, not present if ```redirect_count == 0```

##### Errors

Error | Description
----- | ------------
404   | The ```short code``` cannot be found in the system
