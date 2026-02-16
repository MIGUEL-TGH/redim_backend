<?php
   require_once "ConnectionBD.php";
   require_once "vendor/autoload.php";
   use Firebase\JWT\JWT;

   class ModelsBD{
      //------------------------2026------------------------------------------------    
      static public function setQuery($sql, $params = [], $fetch = 'all'){
          try {
            $stmt = ConnectionBD::CNN()->prepare($sql);
            $stmt->execute($params);

            switch ($fetch) {
               // case 'column':
               //    return $stmt->fetchColumn();
               // case 'none':
               //    return true; // Para INSERT, UPDATE, DELETE

               case 'update':
                  return array(
                     "status"=> 200,
                     "comment" => "The process was successful",
                  );
               case 'one': // find
                  return $stmt->fetch(PDO::FETCH_ASSOC);
               case 'all': // filter
               default:
                  return $stmt->fetchAll(PDO::FETCH_ASSOC);
            }

         } catch (PDOException $e) {
            return [
               "status" => 400,
               "alert"  => "Query execution failed",
               "error"  => $e->getMessage()
            ];
         }
      }

      //------------------------2025------------------------------------------------    
      static public function SelectFrom($sql){
         $stmt = ConnectionBD::CNN()->prepare($sql);
         
         try{ $stmt->execute(); }
         catch(PDOException $e){ return null; }
         return $stmt->fetchAll(PDO::FETCH_ASSOC);
      }
      static public function crud($sql){
         $cnn = ConnectionBD::CNN();
         try {
            $stmt = $cnn->prepare($sql);
            $stmt->execute();

            $result = [
                  'status' => 200,
                  'id' => preg_match('/^INSERT/i', $sql) ? $cnn->lastInsertId() : 0,
                  'affected_rows' => $stmt->rowCount()
            ];

            return $result;
         } catch (PDOException $e) {
            return [
                  'status' => 'Error: ' . $e->getMessage(),
                  'id' => 0,
                  'affected_rows' => 0
            ];
         }
      }

      static public function getFind($sql){
         $stmt = ConnectionBD::CNN()->prepare($sql);
         try{ $stmt->execute(); }
         catch(PDOException $e){ return null; }
         return $stmt->fetch(PDO::FETCH_ASSOC);
      }
      static public function getFilter($sql){
         $stmt = ConnectionBD::CNN()->prepare($sql);
         try{ $stmt->execute(); }
         catch(PDOException $e){ return null; }
         return $stmt->fetchAll(PDO::FETCH_ASSOC);
      }

      //------------------------------------------------------------------------    
      static public function getData($table){
         if(empty(ConnectionBD::getTable($table, ['*']))){
            return null;
         }
         
         $sql = "SELECT * FROM $table";
         $stmt = ConnectionBD::CNN()->prepare($sql);
         try{
            $stmt->execute();
         }catch(PDOException $e){
         return null;
         }
         
         return $stmt->fetchAll(PDO::FETCH_CLASS);
      }
      static public function getDataFind($table, $param, $value){
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
      static protected function getDataFilter($table){
         $sql = "SELECT * FROM $table";
         $stmt = ConnectionBD::CNN()->prepare($sql);
         try{
         $stmt->execute();
         }catch(PDOException $e){
         return null;
         }
         return $stmt->fetchAll(PDO::FETCH_CLASS);
      }
      //------------------------------------------------------------------------
      static public function ifColumnsExist($table, $params){
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

         return array("status"=> 200, "alert"=> "The process was successful"); 
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

         $FindID = ModelsBD::getDataFind($table, 'id', $id);
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
      static public function setDelete($table, $param){
         if(!isset($param['id'])){ return null; }
         $id = $param['id'];

         $FindID = ModelsBD::getDataFind($table, 'id', $id);
         if($FindID == null){
         // $response = array( "comment" => "The id is not foud in the database" );
         // return $response;
         return null;
         }

         $sql = "DELETE FROM `regiones` WHERE id = :$id";
         
         $LINK = ConnectionBD::CNN();
         $stmt = $LINK->prepare($sql);

         $stmt->bindParam(":".$id, $id, PDO::PARAM_STR);

         try{
         if($stmt->execute()){
            $response = array(
               "comment" => "The process was successful"
            );
            return $response;
         }else{          
            return $LINK->errorInfo();
         }
         }
         catch(PDOException $e){  return null; }
      
      }

      //--------------------------------Validations----------------------------------------    
      static public function setJWT($items){
         $key="ippi-siepi-v3-bsdjfgadfre2sd9p8u9y24gdwf34tasbc3ufgcxc";

         if($items['type'] == 'new'){
            $token = array(
               "iat" => time(), // Tiempo de inicio
               "exp" => time() + (60*60*4), // Tiempo de expiracion 4 horas
               // "exp" => time() + (60), // Tiempo de expiracion 4 horas
               "data" => [
                  "id" => $items['id'],
                  "name" => $items['name'],
                  "img" => $items['img'],
                  "pass" => $items['pass']
               ] 
            );
   
            $jwt = JWT::encode($token, $key, 'HS256');
            return array(
               "token" => $jwt,
               "token_exp" => $token['exp']
            );
         }

      }
      static public function parseJWT($token) {
         $tokenParts = explode('.', $token);
     
         if (count($tokenParts) !== 3) {
            throw new Exception('El token JWT debe tener tres partes');
         }
     
         $payload = $tokenParts[1];
         $payload = str_replace(['-', '_'], ['+', '/'], $payload);
         $payload = base64_decode($payload);
         $decodedPayload = json_decode($payload, true);
     
         if (json_last_error() !== JSON_ERROR_NONE) {
             throw new Exception('Error al decodificar el JSON del payload');
         }
     
         return $decodedPayload['data'];
      }
      static public function setValToken($params){
         if(!isset($params['token']) || empty($params['token'])){
            return array("status"=> 400, "res"=> "not-auth", "alert"=> "autorization requied"); 
         }  
       
         $FindLogin = ModelsBD::getDataFind('login', 'token', $params['token']);
         if(empty($FindLogin)){ 
            return array("status"=> 400, "res"=> "not-auth", "alert"=> "the user is not authorized"); 
         }

         if($FindLogin->status == 0){ 
            return array("status"=> 400, "res"=> "not-auth", "alert"=> "the session was closed with this token"); 
         }

         $time = time();
         if($time > $FindLogin->{"token_exp"}){ 
            return array("status"=> 303, "res"=> "expired", "alert"=> "the token has expired", "id_token"=> $FindLogin->{"id"},);
         }
        
         return array("status"=> 200, "res"=> "ok", "alert"=> "the user is authorized", "id_token"=> $FindLogin->{"id"},  "id_user"=> $FindLogin->{"id_user"}); 
      }
      static public function setValApiKey(){ // Acceso Privado
         return '%9g8$Dq&iQ)aG(%{gpuu@(gTW0c(z+';
      }
      static public function setAccesPublic(){ // Acceso Publico
         $tables = ['regiones'];
         return $tables;
      }
   }
?>