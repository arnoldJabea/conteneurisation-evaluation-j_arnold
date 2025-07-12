<?php
declare(strict_types=1);

$env = getenv('APP_ENV') ?: 'prod';
if ($env === 'dev') {
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    echo "<h2>Environnement de développement</h2>";
}

$host = getenv('DB_HOST');
$db   = getenv('DB_NAME');
$user = getenv('DB_USER');
$pass = getenv('DB_PASS');

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $stmt = $pdo->query("SELECT * FROM article");
    echo "<ul>";
    foreach ($stmt as $row) {
        echo "<li><strong>{$row['title']}</strong><br>{$row['body']}</li><hr>";
    }
    echo "</ul>";
} catch (Throwable $e) {
    echo "<p style='color:red'>Erreur : " . htmlspecialchars($e->getMessage()) . "</p>";
}