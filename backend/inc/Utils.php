<?php

class Utils {

    public static function sanitizeInput(string $input): string {
        $input = trim($input);
        $input = strip_tags($input);
        return htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
    }

    public static function getClientIp(): string|null {
        return $_SERVER['REMOTE_ADDR'] ?? null;
    }
    
}
