///Dispatch all piwik tracking requests made during this game-step in one HTTP request.
var i;

//Send post request
if (NetworkIsAvailable && ds_list_size(_PIWIK_REQS) > 0) //CAUTION: This function may return true even if the PIWIK API is not reachable, resulting in a lost tracking request! There is a safety net for this in piwikHTTPAsync().
{
 if (_PiwikDebugOutput)
 {
   show_debug_message("Sending "+string(ds_list_size(_PIWIK_REQS))+" request(s) to piwik this step.");
 }

 //Build list of requests for json object
 var jsonObj = ds_map_create();
 var tmpList = ds_list_create();
 ds_list_copy(tmpList, _PIWIK_REQS);
 ds_map_add_list(jsonObj, "requests",  tmpList);
 var postData = json_encode(jsonObj);
 ds_map_destroy(jsonObj);
 ds_list_destroy(tmpList);
 
 
 //Send post request
 GM_Piwik_httpID[0] = http_post_string(PIWIK_API_URL, postData);
 for(i=0; i<ds_list_size(_PIWIK_REQS); i++) //Pass request array to HTTP Async event
 {
   GM_Piwik_httpID[i+1] = _PIWIK_REQS[| i];
 }
 ds_list_clear(_PIWIK_REQS);
 
}
else
{
   var lstSize = ds_list_size(_PIWIK_REQS);
   if (lstSize > 0)
   {
      if (_PiwikDebugOutput)
      {
        show_debug_message("Sending "+string(lstSize)+" piwik request(s) to local cache this step...");
      }
      for(i=0; i<ds_list_size(_PIWIK_REQS); i++)
      {
        _piwikCacheRequest(_PIWIK_REQS[| i]);
      }
      if (_PiwikDebugOutput)
      {
        show_debug_message("Added "+string(lstSize)+" piwik request(s) to local request cache.");
      }
      ds_list_clear(_PIWIK_REQS);
   }
}
