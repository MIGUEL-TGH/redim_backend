<?php
class DatabaseException extends ApiException {

  public function __construct(string $message = 'Database error') {
    parent::__construct($message, 500);
  }

}
?>