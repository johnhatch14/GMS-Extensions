/*
 Script By Jblund aka. Smallware
 
 argument0 = string you want to split up / explode
 argument1 = substring you want to split the string by
 
 fx.
 argument0 = "hello|very|very|cruel|world"
 arguemnt1 = "|"
 
 array[0] = "hello"
 array[1] = "very"
 ...
 array[4] = "world"
 
 fx.
 argument0 = "abcdefghijklmn"
 argument1 = "defg"
 
 array[0] = "abc"
 array[1] = "hijklmn"
*/

var my_string = argument0;
var explode = argument1;

_explodedstr[]=0;

var numbers = string_count(explode, my_string);

for( var i = 0; i < numbers; i += 1 )
{
    pos = string_pos(explode, my_string);
    _explodedstr[i] = string_copy(my_string, 1, pos-1);
    my_string = string_delete(my_string, 1, pos);
}
//And add the leftover string on the end
_explodedstr[i] = my_string;

return _explodedstr;