/*
 * Piwik Analytics Extension for GameMaker:Studio
 * 
 * Copyright (c) 2015 John Hatch
 * Licenced under the MIT licence: http://opensource.org/licenses/MIT
 */

//Randomize GM's random generator. This ensures unique uids.
randomize();
GM_Piwik_httpID[0] = -1;
GM_Piwik_httpID[1] = "";
GM_Piwik_httpID_cacheReq = -1;

//Apply Configuration
_piwikCONFIG_();

//The minumum custom variable index that can be used in piwikTrackCustomVar. Lower values are used to report OS, browser, and config.
//DON'T CHANGE!
_Piwik_MinCvarIndex = 5;

//Load the stored piwik ini data file, creating it if it does not exist.
      ini_open(_Piwik_IniFile);
      if (file_exists(_Piwik_IniFile) && ini_section_exists("visitor")) //If data file is present and intact...
      {
       //Import and update cached HTTP args
       _Piwik_id = ini_read_string("visitor", "_id", "Unknown");
       
       _Piwik_idvc = ini_read_real("visitor", "_idvc", -1);
       ini_write_real("visitor", "_idts", _Piwik_idvc + 1);
       
       _Piwik_idts = ini_read_real("visitor", "_idts", -1);
       
       _Piwik_viewts = ini_read_real("visitor", "_viewts", -1);
       ini_write_real("visitor", "_viewts", _piwikCurrentTimestamp());
      }
      else //Otherwise, create a data file with first-run data.
      {
       _Piwik_id = md5_string_utf8(string(random(999999999)+game_id));
       ini_write_string("visitor", "_id", _Piwik_id);
       
       _Piwik_idvc = 0;
       ini_write_real("visitor", "_idvc", _Piwik_idvc);
       
       _Piwik_idts = _piwikCurrentTimestamp();
       ini_write_real("visitor", "_idts", _Piwik_idts);
       
       _Piwik_viewts = -1;
      }
      ini_close();

//Send initial request
_piwikSendReq("new_visit=1", "_cvar=" + _piwikGetSystemInfoJson(), "action_name=" + _piwikUrlEncode("Game Started"));
