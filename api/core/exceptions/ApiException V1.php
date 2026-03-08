<?php
  abstract class ApiException extends Exception {

    protected int $status;

    public function __construct( string $message, int $status, $code = 0 ) {
      parent::__construct($message, $code);
      $this->status = $status;
    }

    public function getStatus(): int {
      return $this->status;
    }
  }
?>