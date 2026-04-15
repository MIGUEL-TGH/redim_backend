<?php
require_once "ConnectionBD.php";
class BaseModel {
  public static function query($sql, $params = [], $fetch = 'all') {
    try {
        $stmt = ConnectionBD::CNN()->prepare($sql);
        $stmt->execute($params);

        return match ($fetch) {
            'one' => $stmt->fetch(PDO::FETCH_ASSOC) ?: null,
            'all' => $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [],
            default => true
        };
    } catch(PDOException $e) {
        // Atrapamos el error y lanzamos tu excepción personalizada
        throw new DatabaseException("Error ejecutando consulta SQL (query): " . $e->getMessage());
    }
  }
  public static function getDataFind($table, $param, $value) {
    // 1. Validar que la tabla exista (Error de desarrollo/negocio -> 400)
    if(empty(ConnectionBD::getTable($table, ['*']))) {
        throw new ApiException("La tabla '{$table}' no existe en la base de datos.", 400);
    }

    $sql = "SELECT * FROM {$table} WHERE {$param} = :value LIMIT 1";
    
    try {
        $stmt = ConnectionBD::CNN()->prepare($sql);
        $stmt->bindValue(':value', $value);
        $stmt->execute();
        
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $result ?: null; 
        
    } catch(PDOException $e) {
        throw new DatabaseException("Error al buscar registro en la tabla '{$table}': " . $e->getMessage());
    }
  }
  public static function setInsert($table, $params) {
    $columns = [];
    $placeholders = [];
    
    // Separamos las llaves (columnas) y creamos los placeholders dinámicos
    foreach (array_keys($params) as $key) {
        array_push($columns, $key);
        array_push($placeholders, ":" . $key);
    } 

    // 1. Validar que la tabla y las columnas existan
    if(empty(ConnectionBD::getTable($table, $columns))) {
        throw new ApiException("La tabla '{$table}' o las columnas proporcionadas no existen.", 400); 
    }

    $sql_columns = implode(", ", $columns);
    $sql_placeholders = implode(", ", $placeholders);
         
    $sql = "INSERT INTO {$table} ({$sql_columns}) VALUES ({$sql_placeholders})";
    
    try {
        $LINK = ConnectionBD::CNN();
        $stmt = $LINK->prepare($sql);

        // Bindear parámetros de forma segura
        foreach ($params as $key => $value){
            $stmt->bindValue(":" . $key, $value);
        }

        $stmt->execute();
        
        // Retornamos el éxito y adjuntamos el ID del registro recién creado
        return array(
            "status" => 200,
            "comment" => "El proceso se realizó con éxito",
            "lastInsertId" => $LINK->lastInsertId()
        );
        
    } catch(PDOException $e) {
        // Cualquier error (llaves duplicadas, datos muy largos, etc.) se va al log
        throw new DatabaseException("Error ejecutando INSERT en la tabla '{$table}': " . $e->getMessage());
    }
  }
  public static function setUpdate($table, $id, $params) {
    $columns = [];
    $set = "";
    
    foreach (array_keys($params) as $Key => $value){
        array_push($columns, $value);
        if($value != 'id'){ $set .= $value." = :". $value.","; }
    } 

    $sql_set = substr($set, 0, -1);
        
    // 1. Error de validación estructural (400)
    if(empty(ConnectionBD::getTable($table, $columns))){
        throw new ApiException("La tabla o las columnas proporcionadas no existen.", 400); 
    }

    // 2. Error de registro no encontrado (404)
    $FindID = BaseModel::getDataFind($table, 'id', $id);
    if($FindID == null){
        throw new NotFoundException("El registro especificado no fue encontrado."); 
    }
             
    $sql = "UPDATE $table SET $sql_set WHERE id = :$id";
    $LINK = ConnectionBD::CNN();
    $stmt = $LINK->prepare($sql);

    foreach ($params as $Key => $value){
      if($Key != 'id'){
          $stmt->bindParam(":".$Key, $params[$Key], PDO::PARAM_STR);
      }
    }
    $stmt->bindParam(":".$id, $id, PDO::PARAM_STR);

    // 3. Ejecución de PDO envuelta en Try/Catch
    try {
        $stmt->execute();
        
        return array(
          "status"=> 200,
          "comment" => "El proceso se realizó con éxito"
        );
        
    } catch(PDOException $e) {
      throw new DatabaseException("Error ejecutando UPDATE en la tabla '{$table}': " . $e->getMessage());
    }
  }
}
?>