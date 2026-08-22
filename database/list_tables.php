<?php

$db = new PDO('sqlite:' . __DIR__ . '/../kdpuodtp_kdpub');
$tables = $db->query("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name")->fetchAll(PDO::FETCH_COLUMN);

echo "Total: " . count($tables) . "\n";
print_r($tables);
