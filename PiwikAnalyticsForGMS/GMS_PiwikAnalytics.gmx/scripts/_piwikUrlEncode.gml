/*
  Encodes a string for safe use in a URL. 
  Used extensively for strings in in Piwik's HTTP API.
  
  Usage: piwikUrlEncode(string);
  Returns: URL encoded string.
  
  Thanks to grandhighgamer on the GMC for this script!
  http://gmc.yoyogames.com/index.php?showtopic=645521&p=4699014
*/
var newstr="";
for(i=1; i<=string_length(argument0); i++)
{
    switch(string_char_at(argument0,i))
    {
        case " ": newstr+= "%20"; break;
        case "!": newstr+= "%21"; break;
        case '"': newstr+= "%22"; break;
        case "#": newstr+= "%23"; break;
        case "$": newstr+= "%24"; break;
        case "%": newstr+= "%25"; break;
        case "&": newstr+= "%26"; break;
        case "'": newstr+= "%27"; break;
        case "(": newstr+= "%28"; break;
        case ")": newstr+= "%29"; break;
        case "*": newstr+= "%2A"; break;
        case "+": newstr+= "%2B"; break;
        case ",": newstr+= "%2C"; break;
        case "-": newstr+= "%2D"; break;
        case ".": newstr+= "%2E"; break;
        case "/": newstr+= "%2F"; break;
        case ":": newstr+= "%3A"; break;
        case ";": newstr+= "%3B"; break;
        case "<": newstr+= "%3C"; break;
        case "=": newstr+= "%3D"; break;
        case ">": newstr+= "%3E"; break;
        case "?": newstr+= "%3F"; break;
        case "@": newstr+= "%40"; break;
        case "[": newstr+= "%5B"; break;
        case "\": newstr+= "%5C"; break;
        case "]": newstr+= "%5D"; break;
        case "^": newstr+= "%5E"; break;
        case "_": newstr+= "%5F"; break;
        case "{": newstr+= "%7B"; break;
        case "|": newstr+= "%7C"; break;
        case "}": newstr+= "%7D"; break;
        case "~": newstr+= "%E"; break;
        case "£": newstr+= "%C2%A3"; break;
        default: newstr+= string_char_at(argument0,i);
    }
}
return newstr;