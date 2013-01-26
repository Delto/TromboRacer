<?php
 require_once("database.php");
                echo ("LALALALAL");

                echo ("LALALALAL");

        $connection = new database();
        $coins_info_query = $connection->execute_query("select * from user;");

    if ($coins_info=mysql_fetch_array($coins_info_query))
    {
        $lalala = $coins_info['id'];
                echo ("LALALALAL");
    } else {
                echo ("LOLOLO");
        }
        echo("LELELEL");
        //$connection->no_result_query("insert into user (email) values ('".$_SESSION['email']."')");*/

?>
