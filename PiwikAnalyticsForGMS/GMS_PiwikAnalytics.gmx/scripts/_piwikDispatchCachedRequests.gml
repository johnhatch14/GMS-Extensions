if (file_exists(_Piwik_CacheFile))
{
 if (_PiwikDebugOutput)
 {
    show_debug_message("Piwik: Dispatching cached requests...");
 }
 //Verify cache signature to make sure no unwanted (heaven-forbid, malicious) requests have been added.
 var cacheSig = sha1_string_utf8(sha1_file(_Piwik_CacheFile) + "v5T7uAXnpQ3BGKq" + string(game_id+2563542));
 ini_open(_Piwik_IniFile);
 var storedSig = ini_read_string("cache", "sig", "NULL");
 ini_close();
 if (string_count(storedSig, cacheSig) == 1)
 {
    var fh = file_text_open_read(_Piwik_CacheFile);
    var cacheStr = file_text_read_string(fh);
    file_text_close(fh);
    var salt = _Piwik_CacherSalt;
    var authToken = sha1_string_utf8(string(_piwikCurrentTimestamp()) + salt + string(_piwikCurrentTimestamp()));
    GM_Piwik_httpID_cacheReq = http_post_string(PIWIK_CACHER_URL, "req="+cacheStr+"&t="+authToken);
 }
 else
 {
  if (_PiwikDebugOutput)
     show_debug_message("Piwik Error: Signature mis-match. LOCAL REQUEST-CACHE HAS BEEN TAMPERED WITH! Ninjas are here somewhere...");
  //Erase the corrupt cached requests file. An ounce of lost analytics is worth a pound of security.
  file_delete(_Piwik_CacheFile);
  ini_open(_Piwik_IniFile);
  ini_write_string("cache", "sig", "NULL");
  ini_close();
 }
}
