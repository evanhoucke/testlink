<?php
define('DB_TYPE', if(isset($_SERVER['DB_TYPE']) ? $_SERVER['DB_TYPE']: 'mysql');
define('DB_USER', if(isset($_SERVER['DB_USER']) ? $_SERVER['DB_USER']: 'root');
define('DB_PASS', if(isset($_SERVER['DB_PASS']) ? $_SERVER['DB_PASS']: 'root');
define('DB_HOST', if(isset($_SERVER['DB_HOST']) ? $_SERVER['DB_HOST']: 'database');
define('DB_NAME', if(isset($_SERVER['DB_NAME']) ? $_SERVER['DB_NAME']: 'testlink');
?>
