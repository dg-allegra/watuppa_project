<?php

require_once __DIR__ . '/Config.php';

class RateLimiter {

    public static function hashIp(string $ip): string {
        return 'ip_rate_limiter_' . md5($ip);
    }

    public static function rateLimitExceeded(string $ipHashed): bool {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        $now = time();
        $limitPerSecond = Config::getRateLimit()['requests_per_second'];

        // Se non esiste ancora questo indirizzo IP, inizializzo i dati
        if (!isset($_SESSION['rate_limit'][$ipHashed])) {
            $_SESSION['rate_limit'][$ipHashed] = ['timestamp' => $now, 'requests' => 0];
        }

        $data = &$_SESSION['rate_limit'][$ipHashed];
        // Resetto il contatore se è passato un secondo
        if ($data['timestamp'] !== $now) {
            $data['timestamp'] = $now;
            $data['requests'] = 0;
        }
        $data['requests']++;

        return $data['requests'] > $limitPerSecond;
    }

}
