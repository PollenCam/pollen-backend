<!-- toc -->

<!-- Generated using markdown-toc, except that you have to remove all the %23 in the anchor tags -->

- [TestApplicationsController](#testapplicationscontroller)
  * [GET authenticated JSON endpoint](#get-authenticated-json-endpoint)
    + [without headers CONTENT_TYPE and ACCEPT as application/json](#without-headers-content_type-and-accept-as-applicationjson)
      - [returns Not Acceptable](#returns-not-acceptable)
    + [with headers CONTENT_TYPE and ACCEPT as application/json](#with-headers-content_type-and-accept-as-applicationjson)
      - [without authentication token](#without-authentication-token)
        * [returns unauthorized](#returns-unauthorized)
      - [with authentication token](#with-authentication-token)
        * [returns 2xx success](#returns-2xx-success)
- [Api::Rest::Events#create](#apiresteventscreate)
  * [POST /api/rest/events](#post-apirestevents)
    + [with owner](#with-owner)
      - [creates an event](#creates-an-event)
      - [creates a membership with owner role](#creates-a-membership-with-owner-role)
      - [has a locator](#has-a-locator)
- [Api::Rest::Events#index](#apiresteventsindex)
  * [GET /api/rest/events](#get-apirestevents)
    + [when user owns an event](#when-user-owns-an-event)
      - [returns owned event](#returns-owned-event)
    + [when user owns an event and has a membership to another event](#when-user-owns-an-event-and-has-a-membership-to-another-event)
      - [returns both events](#returns-both-events)
- [Api::Rest::Memberships#create](#apirestmembershipscreate)
  * [POST /api/rest/memberships](#post-apirestmemberships)
    + [with owner](#with-owner-1)
      - [creates a membership](#creates-a-membership)
      - [has attributes](#has-attributes)
- [Api::Rest::UserAccounts#create](#apirestuseraccountscreate)
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
- [Api::Rest::UserAccounts#sign_in](#apirestuseraccountssign_in)
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
  "locator": "RCWN",
  "created_at": "2018-07-16T21:07:52.095Z",
  "updated_at": "2018-07-16T21:07:52.095Z"
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
  "locator": "NVZW",
  "created_at": "2018-07-16T21:07:52.162Z",
  "updated_at": "2018-07-16T21:07:52.162Z"
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
  "locator": "E8D2",
  "created_at": "2018-07-16T21:07:52.193Z",
  "updated_at": "2018-07-16T21:07:52.193Z"
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
      "locator": "Q3E9",
      "created_at": "2018-07-16T21:07:52.232Z",
      "updated_at": "2018-07-16T21:07:52.232Z"
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
      "locator": "6KA4",
      "created_at": "2018-07-16T21:07:52.278Z",
      "updated_at": "2018-07-16T21:07:52.278Z"
    },
    {
      "id": 7,
      "locator": "27PT",
      "created_at": "2018-07-16T21:07:52.293Z",
      "updated_at": "2018-07-16T21:07:52.293Z"
    }
  ]
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
    "event_id": 8
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":8}}
HTTP_X_AUTH_TOKEN: 00000009
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 9,
  "user_id": 9,
  "event_id": 8,
  "role": "attendee",
  "created_at": "2018-07-16T21:07:52.336Z",
  "updated_at": "2018-07-16T21:07:52.336Z"
}
```
#### has attributes
Request to: `/api/rest/memberships`

Request parameters:
```
{
  "membership": {
    "event_id": 9
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":9}}
HTTP_X_AUTH_TOKEN: 00000010
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 10,
  "user_id": 10,
  "event_id": 9,
  "role": "attendee",
  "created_at": "2018-07-16T21:07:52.365Z",
  "updated_at": "2018-07-16T21:07:52.365Z"
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
  "auth_token": "mCkvURB5cPbdGJzdNWP-",
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
  "auth_token": "mwb8bycs72TPeuzNxf9u",
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
  "auth_token": "mygAxexTz7h6_Dk9Ujw6",
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
  "auth_token": "Yb5JZTMpzjTxCsEoZVMP",
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
  "auth_token": "UZ7bPJeKAmytAr6MWL31",
  "email": "test@example.com"
}
```
### returns a different auth token for each user
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "user_11@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_11@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "9msc-DexsyejwyzAihiM",
  "email": "user_11@example.com"
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
    "email": "user_12@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_12@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000012"
}
```
### when given correct login information
#### returns user attributes
Request to: `/api/rest/user_accounts/sign_in`

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
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000013"
}
```
### when given incorrect login information
#### returns errors
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_14@example.com",
    "password": "incorrect"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_14@example.com","password":"incorrect"}}
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
