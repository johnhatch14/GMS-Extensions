# Piwik Analytics Extension for GameMaker:Studio
Piwik (https://piwik.org) is a nice open source alternative to something like Google Analytics when it comes to collecting data about your app's users. That's why I decided to write this small yet useful GameMaker:Studio wrapper for Piwik's RESTful tracking API which should work cross-platform. It also caches events that occurred offline for later upload! 

# Getting Started
* To get Piwik implemented in your GM:S game, you'll first need to have Piwik installed and running on your web server (https://piwik.org/docs/installation/)
* Import the extension `GMS_PiwikAnalytics.gmez` into your GM:S project.
* Customize the script entitled `_piwikCONFIG_` for your installation:
	* 