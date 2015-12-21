# Piwik Analytics Extension for GameMaker:Studio
Piwik (https://piwik.org) is a nice open source alternative to something like Google Analytics when it comes to collecting data about your app's users. That's why I decided to write this small yet useful GameMaker:Studio wrapper for Piwik's RESTful tracking API which should work cross-platform. It also caches events that occurred offline for later upload! 

# Getting Started
* To get Piwik implemented in your GM:S game, you'll first need to have Piwik installed and running on your web server (https://piwik.org/docs/installation/)
* Import the extension file `GMS_PiwikAnalytics.gmez` into your GM:S project.
* Customize these variables in the GML script entitled `_piwikCONFIG_` to fit your Piwik installation and preferences:
	* `PIWIK_API_URL` must be the full public URL to your Piwik installation's `piwik.php` file.
	* `PIWIK_CACHER_URL` should be the URL of the server-side PHP caching script (more on this below).
	* `_Piwik_CacherSalt` should be your custom salt string that the wrapper uses to authenticate with the PHP caching script.
	* `_Piwik_baseurl` can be a 'fake' base URL representing your app as if it were a website (which Piwik is primarily designed for). 
	* `_PiwikDebugOutput` toggles the printing of verbose and debug info about tracking requests to GM's standard output.
	* `_Piwik_idsite` must be the id of your Piwik 'site' as described in YOUR Piwik control panel.
	* `_Piwik_CacheFile` is the name of the file where the GM Piwik wrapper stores cached requests for later upload.
	* `_Piwik_TrackRoomStart` indicates whether the wrapper should automatically track room start events on Piwik.
	* `_Piwik_IniFile' is the name of the file that stores persistent visitor information across visits.
* Place the persistent object `o_PiwikTracker` in the first room of your game, changing it's creation order if need be. <b>Any calls to the GM Piwik wrapper made before this object is created will cause errors!</b>