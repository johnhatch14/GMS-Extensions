/***************************************************
  Send Piwik tracking action.
  Usage:
        arg0 => The title of the action being tracked. 
        
        NOTE: It is possible to use slashes / to set one
        or several categories for this action. 
        For example, Help / Feedback will create the 
        Action Feedback in the category Help.
 ***************************************************/
 with (o_PiwikTracker)
 {
  _piwikSendBasicReq("action_name="+argument0);
 }