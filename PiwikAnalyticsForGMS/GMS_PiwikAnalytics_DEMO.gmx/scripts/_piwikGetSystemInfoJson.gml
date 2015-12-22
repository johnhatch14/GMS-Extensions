/***************************************************
  Returns info about the OS for piwik's custom variables
 ***************************************************/
var os, browser, config, gameversion;

//Deduce OS or browser (for HTML5 games)
if (os_browser == browser_not_a_browser)//Check if we're playing in a web browser
{
 browser = "N/A";
 switch (os_type)
 {
  case os_windows : os = "Windows"; break;
  case os_win8native : os = "Windows 8"; break;
  case os_winphone : os = "Windows Phone"; break;
  case os_linux : os = "Linux"; break;
  case os_macosx : os = "Mac OS X"; break;
  case os_ios : os = "iOS"; break;
  case os_android : os = "Android"; break;
  case os_tizen : os = "Tizen"; break;
  case os_ps3 : os = "Play Station 3"; break;
  case os_ps4 : os = "Play Station 4"; break;
  case os_xbox360 : os = "XBox 360"; break;
  case os_xboxone : os = "XBox One"; break;
  default : os = "Unknown"; break;
 }
}
else //What browser are we being played in?
{
 os = "N/A";
 switch (os_browser)
 {
  case browser_chrome : browser = "Chrome"; break;
  case browser_firefox : browser = "Firefox"; break;
  case browser_ie : browser = "Internet Explorer"; break;
  case browser_opera : browser = "Opera"; break;
  case browser_safari : browser = "Safari"; break;
  case browser_tizen : browser = "Tizen App"; break;
  case browser_windows_store : browser = "Windows 8 App"; break;
  default : browser = "Unknown"; break;
 }
}

config = os_get_config();

var bld_date = string(date_get_month(GM_build_date))+"/"+
               string(date_get_day(GM_build_date))+"/"+
               string(date_get_year(GM_build_date));
               
gameversion = game_display_name + " (Ver. " + GM_version + ", Built " + bld_date +")";

//Compile vars into lists for proper piwik custom-var json format.
//An example of the format can be found here: http://developer.piwik.org/api-reference/tracking-api
var jsonMap = ds_map_create();
var tmp;
tmp[0] = ds_list_create();
ds_list_add(tmp[0], "OS Type", os);
ds_map_add_list(jsonMap, "1" ,tmp[0]);
tmp[1] = ds_list_create();
ds_list_add(tmp[1], "Browser Type", browser);
ds_map_add_list(jsonMap, "2" ,tmp[1]);
tmp[2] = ds_list_create();
ds_list_add(tmp[2], "Build Config", config);
ds_map_add_list(jsonMap, "3" ,tmp[2]);
tmp[3] = ds_list_create();
ds_list_add(tmp[3], "Version", gameversion);
ds_map_add_list(jsonMap, "4" ,tmp[3]);

//Build json string for Piwik custom variables
var jsonStr = json_encode(jsonMap);
ds_map_destroy(jsonMap);

return jsonStr;