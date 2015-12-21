/***************************************************
  Tracks an event through piwik.
  Usage:
        arg0 => The event category. Must not be empty. (eg. Videos, Music, Games...)
        arg1 => The event action. Must not be empty. (eg. Play, Pause, Duration, Add Playlist, Downloaded, Clicked...)
        arg2 => The event name. (eg. a Movie name, or Song name, or File name...)
        arg3 => The event value. Must be a float or integer value (numeric), not a string.
 ***************************************************/
with (o_PiwikTracker)
{
 _piwikSendBasicReq("e_c="+argument0, "e_a="+argument1, "e_n="+argument2, "e_v="+string(argument3));
}
