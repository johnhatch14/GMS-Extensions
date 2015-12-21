//The URL of the piwik.php script on your tracking server. ie. "http://your-piwik-domain.tld/path-to-piwik/piwik.php"
PIWIK_API_URL = "http://www.example.com/path-to-piwik/piwik.php";

//The url of the custom server-side caching script
PIWIK_CACHER_URL = "http://www.example.com/..path to script../addcachedrequests.php";

//Salt string for generating authentication token with server-side caching script
//Best not to hardcode this! Pass it in from a secure function or macro if possible.
_Piwik_CacherSalt = "PASS THE SALT HERE";

//A 'fake' base url representing your app, as if it were a website (which piwik is primarily designed for).
//Include the http://
_Piwik_baseurl = "http://com.organization.appname";

//Whether we should print verbose info (including raw tracking requests) to GM's standard output.
_PiwikDebugOutput = true;

//The id of your piwik 'site' as described in YOUR piwik control panel.
_Piwik_idsite = 3;

//Name of local piwik cache file (can be whatever you want)
_Piwik_CacheFile = "cache.pwk";

//Name of local ini file storing persistant visitor information. 
//NOTE: This is NOT referring to the piwik.ini configuration file on your piwik server.
_Piwik_IniFile = "visitor.pwk";

//Whether to track the start of every room by default
_Piwik_TrackRoomStart = true;

//The minumum custom variable index that can be used in piwikTrackCustomVar.
//Lower values are used to report OS, browser, and other device configuration info.
//***DON'T CHANGE THIS!***
_Piwik_MinCvarIndex = 5;
