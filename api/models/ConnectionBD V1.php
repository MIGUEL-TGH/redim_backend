<?php
   class ConnectionBD{
      static public function InfoBD(){
         $infoBD = array(
            // BD Local
         'host' => 'localhost',
         'user' => 'root',
         'pass' => '',
         'bd' => 'redim', // redim siepi_v2
            // BD Producción
         // 'host' => 'localhost',
         // 'user' => 'stockyap_user_mtgh',
         // 'pass' => 'J6ejv_nQnYe!_~RP',
         // 'bd' => 'stockyap_stockyapp'
         );
         return $infoBD;
      }

      static public function CNN(){
         try{
            $InfoBD = ConnectionBD::InfoBD();
            extract($InfoBD);

            $link = new PDO( "mysql:host=".$host."; dbname=".$bd, $user, $pass );            
            // $link = new PDO(
            //    "mysql:host=localhost; dbname=".ConnectionBD::InfoBD()['bd'],
            //    ConnectionBD::InfoBD()['user'],
            //    ConnectionBD::InfoBD()['pass']
            // );

            $link->exec("set names utf8");

         }catch(PDOException $e){
            die("Error: ".$e->$getMessage());
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