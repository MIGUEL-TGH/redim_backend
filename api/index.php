<?php
define('BASE_PATH', __DIR__);
// composer require firebase/php-jwt
// require_once 'vendor/autoload.php';
// require_once BASE_PATH . '/../vendor/autoload.php'; // Ajusta la ruta a vendor según donde esté la carpeta en tu proyecto
require_once BASE_PATH . '/vendor/autoload.php'; // Ajusta la ruta a vendor según donde esté la carpeta en tu proyecto

// 2. Inicializar dotenv para leer el archivo .env
// Asumiendo que el .env está en redim_backend/ (un nivel arriba de api/)
// composer require vlucas/phpdotenv
$dotenv = Dotenv\Dotenv::createImmutable(BASE_PATH . '/../');
$dotenv->load();

require_once __DIR__ . '/core/exceptions/ApiException.php';
require_once BASE_PATH . '/core/exceptions/ValidationException.php';
require_once BASE_PATH . '/core/exceptions/DatabaseException.php';
require_once BASE_PATH . '/core/exceptions/NotFoundException.php';
require_once BASE_PATH . '/core/BaseController.php';

require_once 'core/cors.php';
require_once 'core/request.php';
require_once 'core/response.php';
require_once 'core/router.php';

Cors::handle();

$router = new Router();
require_once 'routes/auth.routes.php';
require_once 'routes/map.routes.php';
require_once 'routes/years.routes.php';
require_once 'routes/genders.routes.php';
require_once 'routes/countries.routes.php';
require_once 'routes/indicators.routes.php';
require_once 'routes/states.routes.php';
require_once 'routes/centers.routes.php';
require_once 'routes/indicator.categories.routes.php';
require_once 'routes/indicator.category.details.routes.php';

$router->dispatch();

?>