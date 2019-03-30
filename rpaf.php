<?php

// Enables PHP-FPM to recieve the real user REMOTE_ADDR.
$trustedProxies = array(
  '127.0.0.1'  
);

$remote = $_SERVER['REMOTE_ADDR'];

$allowedHeaders = array(
  'HTTP_X_FORWARDED_FOR' => 'REMOTE_ADDR',
  'HTTP_X_REAL_IP' => 'REMOTE_HOST',
  'HTTP_X_FORWARDED_PORT' => 'REMOTE_PORT',
  'HTTP_X_FORWARDED_HTTPS' => 'HTTPS',
  'HTTP_X_FORWARDED_SERVER_ADDR' => 'SERVER_ADDR',
  'HTTP_X_FORWARDED_SERVER_NAME' => 'SERVER_NAME',
  'HTTP_X_FORWARDED_SERVER_PORT' => 'SERVER_PORT',
);

if(in_array($remote, $trustedProxies)) {
  foreach($allowedHeaders as $header => $serverVar) {
    if(isSet($_SERVER[$header])) {
      if(isSet($_SERVER[$serverVar])) {
        $_SERVER["ORIGINAL_$serverVar"] = $_SERVER[$serverVar];
      }
      $_SERVER[$serverVar] = $_SERVER[$header];
    }
  }
}
