<?php
   // $TASK = isset($_GET['Task']) ?  $_GET['Task'] : '*';
   // $Parameters = !empty($_GET) ? $_GET: [];

   header("Content-Type: application/json");
   $value = file_get_contents('php://input');
   $json = json_decode($value, true);
   
   // echo 'routes.php -->' . json_encode($json);
   // return;

   $response = '';
   $REQ_URI = $_SERVER['REQUEST_URI'];
   $URI_EXP = explode("/", $REQ_URI);
   $URI_END = end($URI_EXP);
   $URI = !empty($_GET) ? explode("?", $REQ_URI)[0] : $REQ_URI;

   $METHOD = $_SERVER['REQUEST_METHOD'];
   
   if(empty($URI_END)){
      echo ALERT(400, 'Bad Request');
      return;
   }

   // $HEADERS = getallheaders();
   // if(!isset($HEADERS['apikey'])){
   //    echo ALERT(400, 'Bad Request'); //you are not authorized to make this request
   //    return;
   // }   

   // strtolower($URI);
   if(strlen($URI) != 0){
      switch (strtolower($URI)){
         //--------------------map redim------------------------------
         case '/redim_backend/api/map':
            include "services/serv_map.php";
         break;
         default:
            echo ALERT(406, 'Not Acceptable');
      }
      echo $response;

   } else {
      echo ALERT(404, 'Not Found');
   }

   function ALERT($status, $result){
      $return = array(
         'status' => $status,
         'result' => $result,
      );
      return json_encode($return, http_response_code($return['status']));
   }

?> 