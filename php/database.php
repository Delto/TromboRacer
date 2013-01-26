<?php
class database {
    var $dir = "";
    var $user = "";
    var $pass = "";
    var $connection;

    function __construct() {
    }

    function initialize_connection() {
        $this->connection =  mysql_connect($dir,$user,$pass) or die("Connection Problems");
        mysql_select_db("",$this->connection) or die("problem on access to the database");
    }

	function close_connection() {
        mysql_close($this->connection);
    }
	
	function get_connection() {
        return $this->connection;
    }

	function execute_query($query) {
        $this->initialize_connection();
        $regs=mysql_query($query,$this->connection)
                or die("Problemas en el select:".mysql_error());
        $this->close_connection();
        return $regs;
    }

	function no_result_query($query) {
        $this->initialize_connection();

        $lala=mysql_query($query,$this->connection)
                   or die("InsertFailed".mysql_error());
		$this->close_connection();

    } 
	
	function no_result_queryA($query) {
         //$this->initialize_connection();

         $lala=mysql_query($query,$this->connection)
                 or die("InsertFailed".mysql_error());
			// this->close_connection();

    }
}
?>