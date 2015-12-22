# Piwik Analytics Extension for GameMaker:Studio
Piwik (https://piwik.org) is a nice open source alternative to something like Google Analytics when it comes to collecting data about your app's users. That's why I decided to write this small yet useful GameMaker:Studio wrapper for Piwik's RESTful tracking API which should work cross-platform. It also caches events that occurred offline for later upload! 

# Getting Started
* To get Piwik implemented in your GM:S game, you'll first need to have Piwik installed and running on your web server (https://piwik.org/docs/installation/) and have a Piwik site set up specifically for your game.
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
	* `_Piwik_IniFile` is the name of the file that stores persistent visitor information across visits.
* Place the <u>persistent</u> controller object `o_PiwikTracker` in the first room of your game, changing it's creation order if need be. <b>NOTE: Any calls to the GM Piwik wrapper made before this object is created will cause errors!</b>

If you have everything set up correctly, the extension will send a tracking request to your Piwik server when your game starts that will include various details about the device the game is running on.

# Setting up PHP Cached Request Processor
When cached requests from past dates are sent to the Piwik server, they will need to be inserted directly into the Piwik server's archives. This involves inserting the new requests and marking the date the requests were made for re-archiving by Piwik. In the PHP folder, there is a server-side script called `addcachedrequests.php` that will handle this process for you. All you need to get it working is to edit three variables in it and make the script publicly accessible on your server. <i>Note its public URL for the `PIWIK_CACHER_URL` variable in your `_piwikCONFIG_()` script.</i>

* `$piwikAuthToken` - The authentication token of a Piwik super user. <i><b>NOTE: You should pass this value in from an included script that is not publicly accessible for added security.</b></i>
* `$gmAuthSalt` - Salt for client authentication with this script. This is the salt string that your game uses for authentication with this script. <i>See `_Piwik_CacherSalt` in your `_piwikCONFIG_()` script.</i>
* `$piwikURL` - Full public URL to piwik.php file in your Piwik installation.

# Method Documentation
Once you have the extension set up, tracking analytics in your game to your Piwik server is a piece of cake using the scripts below which can be called by any object! <i>None of the following methods return anything, just FYI.</i>

* <b>`piwikTrackAction( action )`</b> - Send Piwik an action string to track.
	* `action` - The title of the action being tracked.
	* <i>NOTE: It is possible to use slashes / to set one or several categories for this action. For example, Help / Feedback will create the Action Feedback in the category Help.</i>
	
* <b>`piwikTrackContent( name, interaction )`</b> - Tracks the viewing of certain content (like ads or videos)
	* `name` - The name of the content to track (ie. "Banner Ad 1", "Main Intersitial", "Gold Coin Upgrade", etc.)
	* `interaction` - The interaction that occurred (ie. "clicked", "viewed", "dismissed", etc.)
	
* <b>`piwikTrackCustomVar( index, name, value )`</b> - Tracks a custom variable for the current visit.
	* `index` - The index of the custom variable. MUST be greater than `_Piwik_MinCvarIndex` as set in `_piwikCONFIG_()`, or it will be adjusted to be relative to reserved indexes.
	* `name` - The name of the custom variable to track
	* `value` - The value of the custom variable to track
	
* <b>`piwikTrackEvent( category, action, name, value )`</b> - Tracks an event through Piwik.
	* `category` - The event category. Must not be empty. (eg. "Videos", "Music", "Games", etc.)
	* `action` - The event action. Must not be empty. (eg. "Play", "Pause", "Duration", "Add Playlist", "Downloaded", "Clicked", etc.)
	* `name` - The event name. (eg. a Movie name, or Song name, or File name...)
	* `value` - The event value. Must be a numeric value, not a string.
	
* <b>`piwikTrackGoalConversion( id, value )`</b> - Tracks a goal conversion for the specified goal id.
	* `id` - The integer id of the goal to track. This goal id can be found in your piwik control panel.
	* `value` (optional) - The numeric value of the revenue generated by the goal conversion.