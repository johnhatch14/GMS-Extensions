var http_id, http_code, http_res, http_stat;
http_id = async_load[? "id"];
http_code = async_load[? "http_status"];
http_res = async_load[? "result"];
http_stat = async_load[? "status"];

//If this is a tracking request response...
if (http_id == GM_Piwik_httpID[0] && (http_stat > 1 || http_stat == 0))
{ 
  var jsonSz = json_decode(http_res);
  if (string(http_code) != '200' || jsonSz == -1 || "success" != string(jsonSz[? 'status']) ) //Response bad if not 200-OK, or can't be converted to json, or does not report success.
  {
   if (_PiwikDebugOutput)
   {
      show_debug_message("Piwik Error: Bad request response. Caching "+ string(array_length_1d(GM_Piwik_httpID)-1) +" request(s) for later since they didn't go through.");
   }
      
   for (var i=1; i<array_length_1d(GM_Piwik_httpID); i++)
   {
    _piwikCacheRequest(GM_Piwik_httpID[i]);
   }
  }
  else
  {
   _piwikDispatchCachedRequests(); //Try dispatching any cached requests as we seem to have a working connection.
   if (_PiwikDebugOutput)
   {
      show_debug_message("Piwik: Tracking request successful. " + string(jsonSz[? "tracked"]) + " action(s) tracked this frame.");
   }
  }
}

//Otherwise if this is a request-cache dispatch response...
else if (http_id == GM_Piwik_httpID_cacheReq && (http_stat > 1 || http_stat == 0))
{
 var resMap = json_decode(http_res);
 if (string(http_code) == '200' && resMap[? "status"] == "success")
 {
  //Erase the cached requests file as the cached requests have been successfully dispatched.
  file_delete(_Piwik_CacheFile);
  ini_open(_Piwik_IniFile);
  ini_write_string("cache", "sig", "NULL");
  ini_close();
  if (_PiwikDebugOutput)
     show_debug_message("Piwik: Request-cache successfully dispatched and cleared. "+string(resMap[? "tracked"])+" actions(s) tracked.");
 }
 else
 {
  if (_PiwikDebugOutput)
      show_debug_message("Piwik Error: Bad request-cache dispatch response. Retaining request-cache.");
 }
 ds_map_destroy(resMap);
}