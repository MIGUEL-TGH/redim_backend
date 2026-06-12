<?php
    // Solo por linea de comandos (php generateCode.php). Nunca accesible por URL.
    if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }

    echo bin2hex(random_bytes(32));
    echo '<br>';
    echo substr(md5(time()), 0, 6);
?>