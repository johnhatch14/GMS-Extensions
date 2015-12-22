/***************************************************
  Tracks a custom var for the current visit.
  Usage:
        piwikTrackCustomVar( index, name, value )
        index - The index of the custom variable. 
                MUST be greater than _Piwik_MinCvarIndex
                as set in piwikInit(), or it will be adjusted
                to be relative to reserved indexes.
        name  - The name of the custom variable to track
        value - The value of the custom variable to track
 ***************************************************/

with (o_PiwikTracker)
{
   var index, name, value;
   index = argument0;
   name  = argument1;
   value = argument2;
   if (index < _Piwik_MinCvarIndex)
   {
    index = _Piwik_MinCvarIndex + index;
   }
   _piwikSendBasicReq('_cvar={"'+string(index)+'":["'+name+'","'+value+'"]}', 'action_name=' + _piwikUrlEncode("Recording Custom Variable"));
}