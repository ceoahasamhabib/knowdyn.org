<?php

$dir = __DIR__ . '/../public';
if (!is_dir($dir)) {
    mkdir($dir, 0755, true);
}

// 1. Create Apple Touch Icon (180x180)
$size = 180;
$img = imagecreatetruecolor($size, $size);
imagealphablending($img, true);
imagesavealpha($img, true);

// Background Dark #070c18
$bg = imagecolorallocate($img, 7, 12, 24);
imagefilledrectangle($img, 0, 0, $size, $size, $bg);

// Rounded border effect with gradient lines
$indigo = imagecolorallocate($img, 99, 102, 241);
$blue = imagecolorallocate($img, 37, 99, 235);
$rose = imagecolorallocate($img, 225, 29, 72);

for ($i = 0; $i < 6; $i++) {
    imagerectangle($img, $i, $i, $size - 1 - $i, $size - 1 - $i, $indigo);
}

// Draw "KD" text in center
$cyan = imagecolorallocate($img, 96, 165, 250);
$white = imagecolorallocate($img, 255, 255, 255);

// Use large font string
$text = "KD";
$font = 5; // Built-in largest font
$fw = imagefontwidth($font);
$fh = imagefontheight($font);
$tx = ($size - (strlen($text) * $fw * 3)) / 2;
$ty = ($size - ($fh * 3)) / 2;

// Draw enlarged KD block
for ($dx = 0; $dx < 3; $dx++) {
    for ($dy = 0; $dy < 3; $dy++) {
        imagestring($img, $font, 70 + $dx, 75 + $dy, $text, $cyan);
    }
}

imagepng($img, $dir . '/apple-touch-icon.png');
imagepng($img, $dir . '/favicon-32x32.png');
imagepng($img, $dir . '/favicon.ico');

imagedestroy($img);
echo "Successfully generated apple-touch-icon.png, favicon-32x32.png, and favicon.ico!\n";
