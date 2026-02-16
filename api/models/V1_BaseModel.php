<?php
// falta aplicar SRP (Single Responsibility Principle)
require_once "ConnectionBD.php";
class BaseModel {
  public static function query($sql, $params = [], $fetch = 'all') {
    $stmt = ConnectionBD::CNN()->prepare($sql);
    $stmt->execute($params);

    return match ($fetch) {
      'one' => $stmt->fetch(PDO::FETCH_ASSOC),
      'all' => $stmt->fetchAll(PDO::FETCH_ASSOC),
      default => true
    };
  }
  static private function getDataFind($table, $param, $value){
    if(empty(ConnectionBD::getTable($table, ['*']))){
      return null;
    }

    $sql = "SELECT * FROM $table WHERE $param = :$param";
    $stmt = ConnectionBD::CNN()->prepare($sql);
    $stmt->bindParam(":".$param, $value, PDO::PARAM_STR);
    
    try{ $stmt->execute(); }
    catch(PDOException $e){ return null; }

    return $stmt->fetchObject(__CLASS__);
  }
  static public function setInsert($table, $params){
   
    $columns = array();
    $sql_columns = "";
    $sql_params = "";
    foreach (array_keys($params) as $Key => $value){
      array_push($columns, $value);

      $sql_columns .= $value. ","; 
      $sql_params .= ":".$value. ","; 
    }  
         
    if(empty(ConnectionBD::getTable($table, $columns))){
      return array("status"=> 400, "alert"=> "The table or columns not found"); 
    }
         
    $sql_columns = substr($sql_columns, 0, -1);
    $sql_params = substr($sql_params, 0, -1);

    $sql = "INSERT INTO $table ($sql_columns) VALUES ($sql_params)";
    $LINK = ConnectionBD::CNN();
    $stmt = $LINK->prepare($sql);

    foreach ($params as $Key => $value){
      $stmt->bindParam(":".$Key, $params[$Key], PDO::PARAM_STR);
    }

    try{
      if($stmt->execute()){
          return array(
            "status"=> 200,
            "comment" => "The process was successful",
            "id" => $LINK->lastInsertId()
          );
      }else{
          return array(
            "status"=> 400,
            "alert"=> "some of the columns in the table do not meet the characteristics",
            "error"=>  $LINK->errorInfo()
          );
      }
    }catch(PDOException $e){
      return array(
          "status"=> 400,
          "alert"=> "cannot insert item",
          "error"=>  $e
      );
    }

  }
  static public function setUpdate($table, $params){

    if(!isset($params['id'])){ return null; }
      $id = $params['id'];
      $set = "";
      $columns = array();
      foreach (array_keys($params) as $Key => $value){
        array_push($columns, $value);
        if($value != 'id'){ $set .= $value." = :". $value.","; }
    } 

    $sql_set = substr($set, 0, -1);
    if(empty(ConnectionBD::getTable($table, $columns))){
      return array("status"=> 400, "alert"=> "The table or columns not found"); 
    }

    $FindID = BaseModel::getDataFind($table, 'id', $id);
    if($FindID == null){
      return array("status"=> 400, "alert"=> "¡user not found!"); 
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

    try{
      if($stmt->execute()){
        return array(
          "status"=> 200,
          "comment" => "The process was successful",
        );
      }else{          
        return array(
          "status"=> 400,
          "alert"=> "some of the columns in the table do not meet the characteristics",
          "error"=>  $LINK->errorInfo()
        );
      }
    } catch(PDOException $e){  
      return array(
        "status"=> 400,
        "alert"=> "cannot update item",
        "error"=>  $e
      );
    }
  }
}
?>