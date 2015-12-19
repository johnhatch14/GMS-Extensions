/***************************************************
  Tracks the viewing of certain content (esp. Ads)
  Usage:
        piwikTrackContent(name, interaction)
        name - The name of the content to 
               track (ie. Banner Ad 1, Main Intersitial,
               Gold Coin Upgrade, etc.)
        interaction - The interaction that occured 
                      (ie. clicked, viewed, dismissed, etc.)
 ***************************************************/
 var name = argument0;
 var interaction = argument1;
 
 with (o_PiwikTracker)
 {
  _piwikSendBasicReq("c_n="+name, "c_i="+interaction, 'action_name=' + _piwikUrlEncode("Recording Content Interaction"));
 }
