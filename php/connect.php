<?php
 require_once("database.php");	
	$type = $_GET['type'];
	$query = $_GET['query'];
	$connection = new database();

	if($type == "insert") {
		$connection->no_result_query($query);
	} else {
		$select_query = $connection->execute_query($query);
		if ($response=mysql_fetch_array($select_query))
		{
			echo(json_encode($response));
		} else {
		
		}
	}
?>
