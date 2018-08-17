<!-- Generated using `$ markdown-toc -i API_DOCUMENTATION.md`, except that you have to remove all the  in the anchor tags -->

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
- [Api::Rest::Events#create](#apiresteventscreate)
  * [POST /api/rest/events](#post-apirestevents)
    + [with owner](#with-owner)
      - [creates an event](#creates-an-event)
      - [creates a membership with owner role](#creates-a-membership-with-owner-role)
      - [has a locator](#has-a-locator)
- [Api::Rest::PresignedUrls#create](#apirestpresignedurlscreate)
  * [POST /api/rest/events/:event_id/images](#post-apiresteventsevent_idimages)
    + [creates an image](#creates-an-image)
    + [returns a pre-signed url](#returns-a-pre-signed-url)
    + [expires in 3 days](#expires-in-3-days)
    + [without membership](#without-membership)
      - [cannot add an image](#cannot-add-an-image)
      - [as attendee](#as-attendee)
        * [can add an image](#can-add-an-image)
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
  "locator": "E7H2",
  "created_at": "2018-08-17T12:45:24.428Z",
  "updated_at": "2018-08-17T12:45:24.428Z"
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
  "locator": "6RNF",
  "created_at": "2018-08-17T12:45:24.510Z",
  "updated_at": "2018-08-17T12:45:24.510Z"
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
  "locator": "7YTF",
  "created_at": "2018-08-17T12:45:24.534Z",
  "updated_at": "2018-08-17T12:45:24.534Z"
}
```
# Api::Rest::PresignedUrls#create
## POST /api/rest/events/:event_id/images
### creates an image
Request to: `/api/rest/events/4/images`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000005
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "image": {
    "id": 1,
    "presigned_url": "https://pollencam-user-uploads.s3.us-east-2.amazonaws.com/87bf91bc-bfe4-47be-b8ad-e0fd32c57f76?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=THIS_IS_A_FAKE_ACCESS_KEY%2F20180817%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20180817T124524Z&X-Amz-Expires=259200&X-Amz-SignedHeaders=host&X-Amz-Signature=8220461b14ec56636b8f89e0a7544d26db581e780d714c0f36875c083bca860d",
    "final_url": null,
    "uploaded_at": null,
    "membership_id": 4,
    "created_at": "2018-08-17T12:45:24.595Z",
    "updated_at": "2018-08-17T12:45:24.595Z"
  }
}
```
### returns a pre-signed url
Request to: `/api/rest/events/5/images`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000006
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "image": {
    "id": 2,
    "presigned_url": "https://pollencam-user-uploads.s3.us-east-2.amazonaws.com/ec2c01cb-9862-4f03-900d-c2125c5d6db6?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=THIS_IS_A_FAKE_ACCESS_KEY%2F20180817%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20180817T124524Z&X-Amz-Expires=259200&X-Amz-SignedHeaders=host&X-Amz-Signature=65f37f8da15a19e5ec608250cb2ed0eef0411c6ba5da7be5bdf3c6442986232a",
    "final_url": null,
    "uploaded_at": null,
    "membership_id": 5,
    "created_at": "2018-08-17T12:45:24.627Z",
    "updated_at": "2018-08-17T12:45:24.627Z"
  }
}
```
### expires in 3 days
Request to: `/api/rest/events/6/images`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000007
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "image": {
    "id": 3,
    "presigned_url": "https://pollencam-user-uploads.s3.us-east-2.amazonaws.com/d9c36ed0-4ee0-4c60-bbcb-8db41eb43845?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=THIS_IS_A_FAKE_ACCESS_KEY%2F20180817%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20180817T124524Z&X-Amz-Expires=259200&X-Amz-SignedHeaders=host&X-Amz-Signature=1f7b717fe94bca1aa07a79b6578e781b8fbe4809a40aeb60b9cd475894ef549d",
    "final_url": null,
    "uploaded_at": null,
    "membership_id": 6,
    "created_at": "2018-08-17T12:45:24.659Z",
    "updated_at": "2018-08-17T12:45:24.659Z"
  }
}
```
### without membership
#### cannot add an image
Request to: `/api/rest/events/7/images`

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
Response status: `401 Unauthorized`

Response body:

```
NONE
```
#### as attendee
##### can add an image
Request to: `/api/rest/events/10/images`

Request parameters:
```
null
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: null
HTTP_X_AUTH_TOKEN: 00000011
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "image": {
    "id": 4,
    "presigned_url": "https://pollencam-user-uploads.s3.us-east-2.amazonaws.com/d5d197e0-73ee-46d3-81d1-cd39897aeb40?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=THIS_IS_A_FAKE_ACCESS_KEY%2F20180817%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20180817T124524Z&X-Amz-Expires=259200&X-Amz-SignedHeaders=host&X-Amz-Signature=7fe872f7e54bc3f6e7c4263b9bf9b1b903902ff170237db355ede52570c6f2c5",
    "final_url": null,
    "uploaded_at": null,
    "membership_id": 10,
    "created_at": "2018-08-17T12:45:24.760Z",
    "updated_at": "2018-08-17T12:45:24.760Z"
  }
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
HTTP_X_AUTH_TOKEN: 00000013
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
      "id": 12,
      "locator": "8QPS",
      "created_at": "2018-08-17T12:45:24.789Z",
      "updated_at": "2018-08-17T12:45:24.789Z"
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
HTTP_X_AUTH_TOKEN: 00000015
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
      "id": 13,
      "locator": "4P2V",
      "created_at": "2018-08-17T12:45:24.829Z",
      "updated_at": "2018-08-17T12:45:24.829Z"
    },
    {
      "id": 14,
      "locator": "83UA",
      "created_at": "2018-08-17T12:45:24.841Z",
      "updated_at": "2018-08-17T12:45:24.841Z"
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
    "event_id": 15
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":15}}
HTTP_X_AUTH_TOKEN: 00000016
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 17,
  "user_id": 16,
  "event_id": 15,
  "role": "attendee",
  "created_at": "2018-08-17T12:45:24.878Z",
  "updated_at": "2018-08-17T12:45:24.878Z"
}
```
#### has attributes
Request to: `/api/rest/memberships`

Request parameters:
```
{
  "membership": {
    "event_id": 16
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"membership":{"event_id":16}}
HTTP_X_AUTH_TOKEN: 00000017
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "id": 18,
  "user_id": 17,
  "event_id": 16,
  "role": "attendee",
  "created_at": "2018-08-17T12:45:24.903Z",
  "updated_at": "2018-08-17T12:45:24.903Z"
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
  "auth_token": "EDMs5EDec7ND7VP967Qd",
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
  "auth_token": "m6oJDhioZ3tYUnLR2Sz7",
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
  "auth_token": "LxHyiYyNDjZ_zgyEy4wD",
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
  "auth_token": "wKdpz8bX1FMF3rzMJVXx",
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
  "auth_token": "9vyt5sg_WsNquz8N4sWB",
  "email": "test@example.com"
}
```
### returns a different auth token for each user
Request to: `/api/rest/user_accounts`

Request parameters:
```
{
  "user_account": {
    "email": "user_18@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_18@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `201 Created`

Response body:

```
{
  "auth_token": "uqoKSMRRYTf5L12Cpruk",
  "email": "user_18@example.com"
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
    "email": "user_19@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_19@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000019"
}
```
### when given correct login information
#### returns user attributes
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_20@example.com",
    "password": "password"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_20@example.com","password":"password"}}
HTTP_ACCEPT: application/json
CONTENT_TYPE: application/json
```
_______
Response status: `200 OK`

Response body:

```
{
  "auth_token": "00000020"
}
```
### when given incorrect login information
#### returns errors
Request to: `/api/rest/user_accounts/sign_in`

Request parameters:
```
{
  "user_account": {
    "email": "user_21@example.com",
    "password": "incorrect"
  }
}
```

Request headers:

```
REQUEST_METHOD: POST
RAW_POST_DATA: {"user_account":{"email":"user_21@example.com","password":"incorrect"}}
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
