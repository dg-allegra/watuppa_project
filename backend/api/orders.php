<?php

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");
header("Content-type: application/json; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

require_once __DIR__ . '/../db/db.php';
require_once __DIR__ . '/../inc/Utils.php';
require_once __DIR__ . '/../inc/RateLimiter.php';


// Consenti solo richieste GET
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405); 
    echo json_encode(['http_status' => 405, 'message' => 'Metodo non consentito', 'data' => []]);
    exit;
}

// Per evitare troppe richieste dallo stesso indirizzo IP
$ip = Utils::getClientIp();
if ($ip === null) {
    http_response_code(400);
    echo json_encode(['http_status' => 400, 'message' => 'Indirizzo IP client non valido', 'data' => []]);
    exit;
}

$ipHashed = RateLimiter::hashIp($ip);
if (RateLimiter::rateLimitExceeded($ipHashed)) {
    http_response_code(429);
    echo json_encode(['http_status' => 429, 'message' => 'Hai superato il limite di richieste al secondo', 'data' => []]);
    exit;
}


try {
    $email = isset($_GET['email']) ? Utils::sanitizeInput($_GET['email']) : null;

    // Query sugli ordini negli ultimi 30 giorni 
    // Se non fornisco l'email, restituisco gli ordini di tutti gli utenti negli ultimi 30 giorni
    $whereClause = !is_null($email) ? " u.email = ? " : " 1=1 ";

    $sql = "SELECT
            u.email AS email_utente,
            o.id AS id_ordine,
            o.data AS data_ordine,
            p.nome AS nome_prodotto,
            do.quantità,
            do.prezzo
            FROM ordini o
            JOIN utenti u ON o.id_utente = u.id
            JOIN dettaglio_ordine do ON do.id_ordine = o.id
            JOIN prodotti p ON p.id = do.id_prodotto
            WHERE $whereClause
            AND o.data >= DATE_SUB(NOW(), INTERVAL 30 DAY)
            ORDER BY o.data DESC, o.id DESC
    ";

    $results = !is_null($email) ? $db->rawQuery($sql, [$email]) : $db->rawQuery($sql);

    if (empty($results)) {
        http_response_code(404);
        echo json_encode(['http_status' => 404, 'message' => 'Nessun ordine trovato per questa email negli ultimi 30 giorni', 'data' => []]);
        exit;
    }

    http_response_code(200);
    echo json_encode(['http_status' => 200, 'message' => 'OK', 'data' => $results], JSON_UNESCAPED_UNICODE);
    
} catch(Exception $e) {
    http_response_code(500);
    echo json_encode(['http_status' => 500, 'message' => 'Errore server: ' . $e->getMessage(), 'data' => []]);
}