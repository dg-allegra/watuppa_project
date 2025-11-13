<?php 

class Config {

    public static function getRateLimit(): array {
        return [
            'requests_per_second' => 5
        ];
    }
    
}