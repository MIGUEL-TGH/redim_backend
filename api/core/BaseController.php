<?php
abstract class BaseController {
  protected static function handle(callable $callback): void {
    try {
      $data = $callback();
      Response::success($data);

    } catch (ValidationException $e) {      // Errores de validación de formularios (Ej. 422)
      Response::error(
        $e->getMessage(),
        $e->getStatus(),
        $e->getErrors()
      );

    } catch (DatabaseException $e) {        // Errores de DatabaseException ocurridos en la conexión
      $logPath = BASE_PATH . '/php_error_log'; 
      $fecha = date('Y-m-d H:i:s');
      $logMessage = "[{$fecha}] ERROR DB (" . get_class($e) . "): " . $e->getMessage() . " | Archivo: " . $e->getFile() . " | Línea: " . $e->getLine() . PHP_EOL;
      
      // El parámetro 3 le indica a PHP que escriba el texto al final del archivo especificado
      error_log($logMessage, 3, $logPath);

      Response::error('Error interno de la base de datos', 500);

    } catch (ApiException $e) {             // Errores controlados de negocio (Ej. 404, 401). No necesitan log.
      Response::error(
        $e->getMessage(),
        $e->getStatus()
      );

    } catch (Throwable $e) {                // Cualquier otro error crítico inesperado de PHP (Errores de sintaxis, variables indefinidas, etc)
      $logPath = BASE_PATH . '/php_error_log';
      $fecha = date('Y-m-d H:i:s');
      $logMessage = "[{$fecha}] ERROR (" . get_class($e) . "): " . $e->getMessage() . " | Archivo: " . $e->getFile() . " | Línea: " . $e->getLine() . PHP_EOL;

      // El parámetro 3 le indica a PHP que escriba el texto al final del archivo especificado
      error_log($logMessage, 3, $logPath);

      Response::error( 'Internal server error', 500 );

      // ------------------- verificar de donde viene el error----------------------------------------------------------------------
      // Response::error(
      //   get_class($e) . ' - ' . $e->getMessage(),
      //   500
      // );
      
      // -------------------- verificar de donde viene el archivo----------------------------------------------------------------------
      // Response::error(
      //   get_class($e) . ' | FILE: ' . (new ReflectionClass($e))->getFileName(),
      //   500
      // );
    }
  }
}
?>