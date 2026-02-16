<?php
class ValidationException extends ApiException {

  protected array $errors;

  public function __construct(array $errors, string $message = 'Validation error') {
    parent::__construct($message, 422);
    $this->errors = $errors;
  }

  public function getErrors(): array {
    return $this->errors;
  }
}
?>