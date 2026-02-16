<?php
  require_once "controllers/cont_map.php";

  $type = isset($_GET['type']) ?  $_GET['type'] : '';
  $ID = isset($_GET['id']) ?  $_GET['id'] : 0;
   
  switch ($METHOD){
    case 'GET': // Obtener
      if($type == "indicators"){
        $response = map::getIndicators();
      } else if ($type == "years") {
        $response = map::getYears();
      } else if ($type == "states") {
        $response = map::getStates();
      } else if ($type == "genders") {
        $response = map::getGenders();
      }

      break;
    case 'POST': // Insertar
      $response = $type;
      // if($type == "categories"){
      //   $response = map::getIndicatorCategories($value);
      // } else if ($type == "getdata"){
      //   $response = 'En desarrollo';
      //   // $response = map::getDataIndicators($json);
      // }
       break;
    // case 'PUT': // Actualizar
    //    $return = ALERT(400, 'Method under construction');
    //    break;
    // case 'DELETE': // Eliminar
    //    $return = ALERT(400, 'Method under construction');
    //    break;
    default:
      $return = ALERT(405, 'Method Not Allowed');
  } 
?>