<?php
// phpinfo();

// Test MySQL connection
try {
    $pdo = new PDO(
        'mysql:host=mysql;dbname=test',
        'appuser',
        '123456'
    );
    echo "<h2>✅ MySQL Connected!</h2>";
} catch (PDOException $e) {
    echo "<h2>❌ MySQL Error:</h2> " . $e->getMessage();
}

