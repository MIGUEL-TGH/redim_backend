<?php
class Response {
  //------------------------------------------------------------------------------------------------
  public static function json($data, $status = 200) {
    http_response_code($status);
    echo json_encode([
      'status' => $status,
      'data' => $data
    ]);
    exit;
  }
  public static function error_($message, $status = 400) {
    self::json(['error' => $message], $status);
  }

  //------------------------------------------------------------------------------------------------
  public function setResponse($data = null, $error = null, $status = 200) {

    http_response_code($status);

    if ($error === null) {
      echo json_encode([
        'status' => $status,
        'total'  => is_array($data) ? count($data) : ($data ? 1 : 0),
        'result'   => $data
      ]);
    } else {
      echo json_encode([
        'status' => $status,
        'error'  => $error
      ]);
    }

    exit;
  }
  public static function setResponse_V1($data, $error, $status = 200){
    if (!empty($data)) {
      $result = array(
        'status' => 200,
        'total' => (is_array($data)) ? count($data) : 1,
        'result' => $data,
      );
    } else {
      if($error == null){
        $result = array(
          'status' => 404,
          'result' => 'Result Not Found',
        );
      }
      else{
        $result = array(
          'status' => $status,
          'result' => 'Error --> '.$error,
        );
      }
    }
    echo json_encode($result, http_response_code($result['status']));
  }

  //------------------------------------------------------------------------------------------------
  public static function send (int $status, bool $success, string $message, $data = null, $errors = null ): void {
    http_response_code($status);

    $response = [
      'status'  => $status,
      'success' => $success,
      'message' => $message,
    ];

    if ($success) {
      $response['total'] = is_array($data) ? count($data) : ($data ? 1 : 0);
      // $response['data']  = $data;
      $response['result']  = $data;
    } else {
      $response['errors'] = $errors;
    }

    echo json_encode($response);
    exit;
  }
  public static function success($data = null, string $message = 'OK'): void {
    self::send(200, true, $message, $data);
  }
  public static function created($data = null): void {
    self::send(201, true, 'Resource created', $data);
  }
  public static function error(string $message, int $status = 400, $errors = null ): void {
    self::send($status, false, $message, null, $errors);
  }
}
?>