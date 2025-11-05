<?php

require_once __DIR__ . '/dbconfig.php'; 
require_once __DIR__ . '/../libs/vendor/thingengineer/mysqli-database-class/MysqliDb.php'; 

try {
    $db = new MysqliDb(Array
    (
        'host' => $dbconfig['host'],
        'username' => $dbconfig['username'],
        'password' => $dbconfig['password'],
        'db'=> $dbconfig['db']
    ));

    $mysqli = $db->mysqli();
    if ($mysqli->connect_errno) {
        throw new Exception($mysqli->connect_error);
        exit;
    }

} catch(Exception $e) {
    echo "Errore di connessione al database: " . $e->getMessage();
    exit;
}