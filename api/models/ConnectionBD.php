<?php
   class ConnectionBD{
      static public function InfoBD(){
         $infoBD = array(
         'host' => $_ENV['DB_HOST'],
         'port' => $_ENV['DB_PORT'] ?? '3306',
         'user' => $_ENV['DB_USER'],
         'pass' => $_ENV['DB_PASS'],
         'bd'   => $_ENV['DB_NAME']
         );
         return $infoBD;
      }

      static public function CNN(){
         try{
            $InfoBD = ConnectionBD::InfoBD();
            extract($InfoBD);

            $link = new PDO( "mysql:host=".$host.";port=".$port.";dbname=".$bd, $user, $pass );
            $link->exec("set names utf8");

         }catch(PDOException $e){
            throw new DatabaseException("Fallo en PDO: " . $e->getMessage());
         }
         return $link;
      }

      static public function getTable($table, $columns){
         $InfoBD = ConnectionBD::InfoBD();
         extract($InfoBD);
         
         $result = ConnectionBD::CNN()
         ->query("SELECT COLUMN_NAME AS item FROM information_schema.columns WHERE table_schema = '$bd' AND table_name = '$table';")
         ->fetchAll(PDO::FETCH_OBJ);

         if(empty($result)){
            return null; // La tabla no existe
         }else{
            
            if($columns[0] == '*'){
               array_shift($columns);
            }
            
            $cant = 0;
            foreach($result as $key => $value){
               $cant += in_array($value->item, $columns);
            }
            
            return ($cant == count($columns)) ? $result : null;
         }


      }

   }
?>