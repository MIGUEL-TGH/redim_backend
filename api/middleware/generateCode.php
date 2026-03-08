<?php
    echo bin2hex(random_bytes(32));
    echo '<br>';
    echo substr(md5(time()), 0, 6);
?>