<?php
require_once(dirname(__FILE__)."/../bin/config.php");
require_once(WWW_DIR ."/lib/framework/db.php");
require_once(WWW_DIR ."/lib/util.php");
require_once ("hashcompare.php");

    $key = 'CHANGE';
   
	
	$src = "https://pre.corrupt-net.org/rss.php?k=".$key;	
	
	echo "pre.corrupt.net - request...";
	$apiresponse = getUrl($src); 
		
	if ($apiresponse)
	{
			
			if (strlen($apiresponse) > 0) 
			{
				echo "response\n";
				$preinfo = simplexml_load_string($apiresponse);
		
				foreach($preinfo->channel->item as $item) 
				{
					$cleanname = trim(substr($item->title , strpos( $item->title,']')+ 1));
					$res  = getRelease($cleanname);
					
					if ($res['total'] == 0)
					{	
						AddRelease($cleanname, $item->pubDate);
						//echo "\n Added - ".$cleanname."\n";
					}
		
				}

			}else{
				echo "response was zero length :( \n";
			}
	}else{
			echo "nothing came :( \n";
	}
	
?>