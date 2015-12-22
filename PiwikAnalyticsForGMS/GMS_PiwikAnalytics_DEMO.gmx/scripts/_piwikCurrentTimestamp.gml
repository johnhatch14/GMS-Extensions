//Simply calculates and returns the current UTC timestamp.
var tz = date_get_timezone();
date_set_timezone(timezone_utc);
var timestamp = date_second_span(date_create_datetime(1970,1,1,0,0,0), date_current_datetime());
date_set_timezone(tz);

return timestamp;