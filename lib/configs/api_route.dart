//Main HOST
String baseUrl = "http://192.168.1.210:42013";

//URI
//GET
String uriGetEvent = "/Service/api/viewPersonEvent";
String uriGetCamera = "/Service/api/Device";
String uriGetArea = "/Service/api/areas";
String uriGetCameraFunction = "/api/v1/camera-function";
String uriGetBlackList = "/api/v1/plate-in-blacklist";

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

//URL

//AUTH
String urlAuth = "$baseUrl$uriAuth";

//DATA
String urlGetEvent = "$baseUrl$uriGetEvent";
String urlGetCamera = "$baseUrl$uriGetCamera";
String urlGetArea = "$baseUrl$uriGetArea";
String urlGetCameraFunction = "$baseUrl$uriGetCameraFunction";
String urlGetBlackList = "$baseUrl$uriGetBlackList";

//FILE SERVICE
String urlFileService = "$baseUrl/Service/files";
