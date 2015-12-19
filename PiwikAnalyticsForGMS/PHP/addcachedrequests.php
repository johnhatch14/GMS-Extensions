<?php

///////////////////////////////////////////////////
// THESE ARE THE ONLY THREE VALUES YOU NEED TO CUSTOMIZE:
///////////////////////////////////////////////////

$piwikAuthToken = 'PUT THE SUPERUSER TOKEN HERE'; // Authentication token of a PIWIK super user
$gmAuthSalt     = 'PASS THE SALT HERE'; // Salt for client authentication with this script

$piwikURL 		= 'http://www.example.com/path-to-piwik/piwik.php'; // FULL public URL to piwik.php file

///////////////////////////////////////////////////

$validGMAuthTokens = array();
$maxAbsTokenErr = 2; //Max error of +- 3 seconds.
for ($i = -$maxAbsTokenErr; $i <= $maxAbsTokenErr; $i++)
{
	array_push($validGMAuthTokens, sha1(strval(time()+$i).$gmAuthSalt.strval(time()+$i)));
}

$payloadStr = isset( $_POST['req'] ) ? $_POST['req'] : -1;
$gmAuthToken = isset( $_POST['t'] ) ? $_POST['t'] : -1;

if ($gmAuthToken == -1 || array_search($gmAuthToken, $validGMAuthTokens) === false)
{
		http_response_code(403);
		die(json_encode(array('result' => 'failure', 'reason' => 'Forbidden'), true));
}

if ($payloadStr == -1)
{
	http_response_code(400);
	die('Bad Payload');
}
else
{
	$jsonArray = json_decode(base64_decode($payloadStr), true);
	//Pull out the dates and idsite numbers that will need to have their reports updated
	//See http://piwik.org/faq/how-to/faq_155/
	$requestArray = $jsonArray['requests'];
	$reqVars['idSites'] = array();
	$reqVars['dates']   = array();
	
	$newRequestArray = array();
	foreach ($requestArray as $request)
	{
		$request = ltrim($request, "?");//Take out the leading ? char so it doesn't get url_encoded. We'll stick it back on later
		parse_str($request, $qvars);
		
		//Force the requester's IP to be reported rather than this server's IP.
		$qvars['cip'] = urlencode(getUserIP());
		
		array_push($newRequestArray, "?" . http_build_query($qvars)); //Stick the request vars back together and pre-pend the ? char.
		array_push($reqVars['idSites'], rawurldecode($qvars['idsite']));
		array_push($reqVars['dates'], explode(' ', rawurldecode($qvars['cdt']))[0]);
	}

	//remove duplicates
	$reqVars['idSites'] = array_keys(array_flip($reqVars['idSites']));
	$reqVars['dates']   = array_keys(array_flip($reqVars['dates']));
	
	//Rebuild modified list of queries and authenticate request batch
	$jsonArray = array();
	$jsonArray['requests'] = $newRequestArray;
	$jsonArray['token_auth'] = $piwikAuthToken; //Authenticate the request batch.
	
	//Recompile request into url-encoded sendable json string.
	$json_signedRequests = str_replace("\r\n"," ",json_encode($jsonArray));
	//echo "<b>Request Data:</b> <br/>";
	//echo $json_signedRequests;
	
	//Build record updating request
	/*
	 * Ex.
	 * ["?module=API&
	 * method=CoreAdminHome.invalidateArchivedReports&
	 * idSites=1,3,5&
	 * dates=2012-01-01,2011-10-15&
	 * token_auth=xyz"]
	*/
	$stringOfidSites = '';
	$stringOfDates = '';
	foreach ($reqVars['idSites'] as $idSite)
	{
		$stringOfidSites .= strval($idSite) . ",";
	}
	foreach ($reqVars['dates'] as $d)
	{
		$stringOfDates .= strval($d) . ",";
	}
	$stringOfidSites = trim($stringOfidSites, ',');
	$stringOfDates = trim($stringOfDates, ',');
	
	if (count($reqVars['idSites']) > 1)
	{
		$stringOfidSites = "idSites=" . $stringOfidSites;
	}
	else
	{
		$stringOfidSites = "idSites=" . $stringOfidSites;
	}
	
	//open connection
	$ci = curl_init();

	//set the url, number of POST vars, POST data
	curl_setopt($ci,CURLOPT_URL, $piwikURL);
	curl_setopt($ci,CURLOPT_POST, true);
	curl_setopt($ci,CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ci,CURLOPT_POSTFIELDS, $json_signedRequests);

	//Execute request
	$res = curl_exec($ci);
	curl_close($ci);
	//echo "<b>Result:</b> <br/>";
	//var_dump($res);
	
	if ($res != false && $res != null)
	{
		$res = json_decode($res, true);
		//echo "<b>Result Json:</b> <br/>";
		if ($res['status'] == 'success')
		{
			$ch = curl_init();
			curl_setopt($ch,
			CURLOPT_URL,
				$piwikURL . 
				'?module=API&method=CoreAdminHome.invalidateArchivedReports&'.
				$stringOfidSites.
				'&dates='.$stringOfDates.
				'&token_auth='.$piwikAuthToken
			);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER, true);
			$archiveRes = curl_exec($ch);
			curl_close($ch);
			if ($archiveRes != false && $archiveRes != null)
			{
				http_response_code(200);
				die(json_encode($res, true));
			}
			else
			{
				http_response_code(420);
				die(json_encode(array(
				'result' => 'failure', 
				'reason' => 'Bad response from archive invalidator.'
				), true)
				);
			}
			echo "<b>Update request result:</b> <br/>";
			var_dump($res);
		}
		else
		{
			die(json_encode($res, true));
		}
	}
	else
	{
		http_response_code(420);
		die(json_encode(array('result' => 'failure', 'reason' => 'Bad response from bulk tracking request.'), true));
	}
}

function getUserIP() {
    if( array_key_exists('HTTP_X_FORWARDED_FOR', $_SERVER) && !empty($_SERVER['HTTP_X_FORWARDED_FOR']) ) {
        if (strpos($_SERVER['HTTP_X_FORWARDED_FOR'], ',')>0) {
            $addr = explode(",",$_SERVER['HTTP_X_FORWARDED_FOR']);
            return trim($addr[0]);
        } else {
            return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }
    }
    else {
        return $_SERVER['REMOTE_ADDR'];
    }
}
?>