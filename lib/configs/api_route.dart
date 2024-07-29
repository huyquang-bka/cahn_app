//GET
String uriGetEvent = "/Service/api/lookup/personEvent";
String uriGetCamera = "/Service/api/lookup/device";
String uriGetArea = "/Service/api/lookup/area";

//POST
//auth
String uriAuth = "/Service/api/token/auth";
Map<String, String> bodyAuth = {
    "username": "",
    "password": "",
    "grant_type": "password",
    "client_id": "HVQP_Cloud",
    "client_secret": "1a82f1d60ba6353bb64a8fb4b05e4bc4"
};

Map<String, String> bodyRefreshToken = {
  "grant_type": "password",
  "client_id": "EPS",
  "client_secret": "b0udcdl8k80cqiyt63uq",
  "refresh_token": "",
};
