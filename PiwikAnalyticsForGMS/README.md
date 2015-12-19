# Piwik Analytics Extension for GameMaker:Studio
Piwik (https://piwik.org) is a nice open source alternative to something like Google Analytics when it comes to collecting data about your app's users. That's why I decided to write this small yet useful GameMaker:Studio wrapper for Piwik's RESTful tracking API which should work cross-platform. It also caches events that occurred offline for later upload! 

# Getting Started
* To get Piwik implemented in your GM:S game, you'll first need to have Piwik installed and running on your web server (https://piwik.org/docs/installation/)
* Import the extension file `GMS_PiwikAnalytics.gmez` into your GM:S project.
* Customize the GML script entitled `_piwikCONFIG_` for your Piwik installation:
	* `PIWIK_API_URL` should be the full public URL to your Piwik installation's `piwik.php` file.
	* `PIWIK_CACHER_URL` should be the URL of the server-side PHP caching script (more on this below).
	* `_Piwik_CacherSalt` is the salt that the wrapper uses to authenticate with it's PHP caching script.
	* WIP...