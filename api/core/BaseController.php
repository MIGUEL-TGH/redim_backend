<?php
abstract class BaseController {

  protected static function handle(callable $callback): void {
    try {

      $data = $callback();
      Response::success($data);

    } catch (ValidationException $e) {

      Response::error(
        $e->getMessage(),
        $e->getStatus(),
        $e->getErrors()
      );

    } catch (ApiException $e) {

      Response::error(
        $e->getMessage(),
        $e->getStatus()
      );

    } catch (Throwable $e) {

      Response::error(
        'Internal server error',
        500
      );
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