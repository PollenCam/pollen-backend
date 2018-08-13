<!-- Generated using `$ markdown-toc -i API_DOCUMENTATION.md`, except that you have to remove all the %23 in the anchor tags -->

<!-- toc -->

- [TestApplicationsController](#testapplicationscontroller)
  * [GET authenticated JSON endpoint](#get-authenticated-json-endpoint)
    + [without headers CONTENT_TYPE and ACCEPT as application/json](#without-headers-content_type-and-accept-as-applicationjson)
      - [returns Not Acceptable](#returns-not-acceptable)
    + [with headers CONTENT_TYPE and ACCEPT as application/json](#with-headers-content_type-and-accept-as-applicationjson)
      - [without authentication token](#without-authentication-token)
        * [returns unauthorized](#returns-unauthorized)
      - [with authentication token](#with-authentication-token)
        * [returns 2xx success](#returns-2xx-success)
- [Api::Rest::Events#create](#apirestevents%23create)
  * [POST /api/rest/events](#post-apirestevents)
    + [with owner](#with-owner)
      - [creates an event](#creates-an-event)
      - [creates a membership with owner role](#creates-a-membership-with-owner-role)
      - [has a locator](#has-a-locator)
- [Api::Rest::Events#index](#apirestevents%23index)
  * [GET /api/rest/events](#get-apirestevents)
    + [when user owns an event](#when-user-owns-an-event)
      - [returns owned event](#returns-owned-event)
    + [when user owns an event and has a membership to another event](#when-user-owns-an-event-and-has-a-membership-to-another-event)
      - [returns both events](#returns-both-events)
- [Api::Rest::PresignedUrls#create](#apirestpresignedurls%23create)
  * [POST /api/rest/presigned_urls](#post-apirestpresigned_urls)
    + [returns a pre-signed url](#returns-a-pre-signed-url)
    + [expires in 3 days](#expires-in-3-days)
- [Api::Rest::Memberships#create](#apirestmemberships%23create)
  * [POST /api/rest/memberships](#post-apirestmemberships)
    + [with owner](#with-owner-1)
      - [creates a membership](#creates-a-membership)
      - [has attributes](#has-attributes)
- [Api::Rest::UserAccounts#create](#apirestuseraccounts%23create)
  * [POST /api/rest/user_accounts](#post-apirestuser_accounts)
    + [does not require authentication](#does-not-require-authentication)
    + [registers the user](#registers-the-user)
    + [creates a new User](#creates-a-new-user)
    + [returns json](#returns-json)
    + [returns an auth token](#returns-an-auth-token)
    + [returns a different auth token for each user](#returns-a-different-auth-token-for-each-user)
    + [when email taken](#when-email-taken)
      - [does not create another user](#does-not-create-another-user)
      - [indicates email has been taken](#indicates-email-has-been-taken)
- [Api::Rest::UserAccounts#sign_in](#apirestuseraccounts%23sign_in)
  * [POST /api/rest/user_accounts/sign_in](#post-apirestuser_accountssign_in)
    + [does not require authentication](#does-not-require-authentication-1)
    + [when given correct login information](#when-given-correct-login-information)
      - [returns user attributes](#returns-user-attributes)
    + [when given incorrect login information](#when-given-incorrect-login-information)
      - [returns errors](#returns-errors)

<!-- tocstop -->

# TestApplicationsController
## GET authenticated JSON endpoint
### without headers CONTENT_TYPE and ACCEPT as application/json
#### returns Not Acceptable
Request to: `/test_application`

Request parameters:
```
NONE
```

Request headers:

```
REQUEST_METHOD: GET
HTTP_ACCEPT: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
```
_______
Response status: `406 Not Acceptable`

Response body:

```
NONE
```
### with headers CONTENT_TYPE and ACCEPT as application/json
#### without authentication token
##### returns unauthorized
Request to: `/unauthenticated`

Request parameters:
```
NONE
```

Request headers:

```
REQUEST_METHOD: GET
QUERY_STRING: null
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `401 Unauthorized`

Response body:

```
{
  "error": "Please authenticate with a valid token"
}
```
#### with authentication token
##### returns 2xx success
Request to: `/test_application`

Request parameters:
```
NONE
```

Request headers:

```
REQUEST_METHOD: GET
QUERY_STRING: null
HTTP_X_AUTH_TOKEN: 00000001
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `204 No Content`

Response body:

```
NONE
```
# Api::Rest::Events#create
## POST /api/rest/events
### with owner
#### creates an event
Request to: `/api/rest/events`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000002
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 1,
  "locator": "CET6",
  "created_at": "2018-08-12T22:27:22.358Z",
  "updated_at": "2018-08-12T22:27:22.358Z"
}
```
#### creates a membership with owner role
Request to: `/api/rest/events`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000003
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 2,
  "locator": "5XBP",
  "created_at": "2018-08-12T22:27:22.418Z",
  "updated_at": "2018-08-12T22:27:22.418Z"
}
```
#### has a locator
Request to: `/api/rest/events`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000004
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 3,
  "locator": "4V8E",
  "created_at": "2018-08-12T22:27:22.444Z",
  "updated_at": "2018-08-12T22:27:22.444Z"
}
```
# Api::Rest::Events#index
## GET /api/rest/events
### when user owns an event
#### returns owned event
Request to: `/api/rest/events`

Request parameters:
```
NONE
```

Request headers:

```
REQUEST_METHOD: GET
QUERY_STRING: null
HTTP_X_AUTH_TOKEN: 00000006
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "events": [
    {
      "id": 5,
      "locator": "CX57",
      "created_at": "2018-08-12T22:27:22.487Z",
      "updated_at": "2018-08-12T22:27:22.487Z"
    }
  ]
}
```
### when user owns an event and has a membership to another event
#### returns both events
Request to: `/api/rest/events`

Request parameters:
```
NONE
```

Request headers:

```
REQUEST_METHOD: GET
QUERY_STRING: null
HTTP_X_AUTH_TOKEN: 00000008
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "events": [
    {
      "id": 6,
      "locator": "4H9D",
      "created_at": "2018-08-12T22:27:22.524Z",
      "updated_at": "2018-08-12T22:27:22.524Z"
    },
    {
      "id": 7,
      "locator": "KFPM",
      "created_at": "2018-08-12T22:27:22.538Z",
      "updated_at": "2018-08-12T22:27:22.538Z"
    }
  ]
}
```
# Api::Rest::PresignedUrls#create
## POST /api/rest/presigned_urls
### returns a pre-signed url
Request to: `/api/rest/presigned_urls`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000009
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "presigned_url": "https://blabla.bla"
}
```
### expires in 3 days
Request to: `/api/rest/presigned_urls`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000010
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "presigned_url": "https://blabla.bla"
}
```
# Api::Rest::Memberships#create
## POST /api/rest/memberships
### with owner
#### creates a membership
Request to: `/api/rest/memberships`

Request parameters:
```
{
  "membership": {
    "event_id": 10
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":10}}
HTTP_X_AUTH_TOKEN: 00000011
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 11,
  "user_id": 11,
  "event_id": 10,
  "role": "attendee",
  "created_at": "2018-08-12T22:27:23.114Z",
  "updated_at": "2018-08-12T22:27:23.114Z"
}
```
#### has attributes
Request to: `/api/rest/memberships`

Request parameters:
```
{
  "membership": {
    "event_id": 11
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":11}}
HTTP_X_AUTH_TOKEN: 00000012
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 12,
  "user_id": 12,
  "event_id": 11,
  "role": "attendee",
  "created_at": "2018-08-12T22:27:23.139Z",
  "updated_at": "2018-08-12T22:27:23.139Z"
}
```
# Api::Rest::UserAccounts#create
## POST /api/rest/user_accounts
### does not require authentication
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "fM-ZbLZXfxxQ8z_9wikd",
  "email": "test@example.com"
}
```
### registers the user
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "sk6n_8saACkFGaMSxePZ",
  "email": "test@example.com"
}
```
### creates a new User
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "aybYz5ChKRwNUMRSYw2z",
  "email": "test@example.com"
}
```
### returns json
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "zT4_2AgSQHnxeLB4xGci",
  "email": "test@example.com"
}
```
### returns an auth token
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "FzoZ1G3J5eUKJoV7Vaj7",
  "email": "test@example.com"
}
```
### returns a different auth token for each user
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "user_13@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_13@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "bSjhWyt5nQUpR8e7F7cF",
  "email": "user_13@example.com"
}
```
### when email taken
#### does not create another user
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `400 Bad Request`

Response body:

```
{
  "errors": {
    "email": [
      "has already been taken"
    ]
  }
}
```
#### indicates email has been taken
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "test@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"test@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `400 Bad Request`

Response body:

```
{
  "errors": {
    "email": [
      "has already been taken"
    ]
  }
}
```
# Api::Rest::UserAccounts#sign_in
## POST /api/rest/user_accounts/sign_in
### does not require authentication
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_14@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_14@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000014"
}
```
### when given correct login information
#### returns user attributes
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_15@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_15@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000015"
}
```
### when given incorrect login information
#### returns errors
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_16@example.com",
    "password": "incorrect"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_16@example.com","password":"incorrect"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `401 Unauthorized`

Response body:

```
{
  "errors": {
    "login": [
      "Bad password or email address"
    ]
  }
}
```
