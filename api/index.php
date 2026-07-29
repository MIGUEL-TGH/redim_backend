<?php
define('BASE_PATH', __DIR__);

require_once BASE_PATH . '/vendor/autoload.php';

// 2. Inicializar dotenv para leer el archivo .env
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
require_once 'routes/users.routes.php';
require_once 'routes/sesnsp.routes.php';
require_once 'routes/cnsipee.routes.php';
require_once 'routes/visits.routes.php';

// Módulos de contenido administrable (vistas públicas)
require_once 'routes/voces_videos.routes.php';
require_once 'routes/voces_podcasts.routes.php';
require_once 'routes/voces_testimonials.routes.php';
require_once 'routes/recursos_studies.routes.php';
require_once 'routes/recursos_downloads.routes.php';
require_once 'routes/tv_videos.routes.php';
require_once 'routes/tv_social_buttons.routes.php';
require_once 'routes/miradas_works.routes.php';
require_once 'routes/miradas_contest_links.routes.php';
require_once 'routes/actuamos_gallery.routes.php';
require_once 'routes/actuamos_acciones.routes.php';
require_once 'routes/mapa_state_posts.routes.php';
require_once 'routes/actuamos_internacional.routes.php';
require_once 'routes/history_categories.routes.php';
require_once 'routes/history_category_details.routes.php';
require_once 'routes/help_contacts.routes.php';
require_once 'routes/help_settings.routes.php';
require_once 'routes/transparencia_sections.routes.php';
require_once 'routes/transparencia_docs.routes.php';
require_once 'routes/state_descriptions.routes.php';

$router->dispatch();

?>