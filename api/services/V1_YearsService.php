<?php
require_once "models/BaseModel.php";

class YearsService {
  //--------------------private access------------------------------------------- 
  //--------------------public access-------------------------------------------        
  public static function getYears() {
    try {
      $sql = 
        "SELECT y.id, y.name, y.status
        FROM years y
        ORDER BY y.name DESC;
      ";
      // WHERE y.status = ?
      $result = [];
      $items = BaseModel::query($sql, [], 'all');
      if(!empty($items)){
        foreach ($items as $item) {
          $result[] = array(
            'id' => $item['id'], 
            'name' => $item['name'], 
            'status' => ($item['status'] === 1) ? true : false 
          );
        }
      }

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($result)) {
      throw new NotFoundException('¡items not found!');
    }

    return $result;
  }
  public static function setCRUD($data) {
    $params = $data['params'];

    if ($data['task'] === 'insert' || $data['task'] === 'update') {
      if (!preg_match("/^\d{4}$/", $params['name'])) {
        throw new ValidationException (
          [ 'type' => 'Invalid type parameter' ],
          'El formato no cumple con las características YYYY'
        );    
      }
    }

    try {

      $result = [];
      switch ($data['task']) {
        case 'insert': // insert
            $insert = BaseModel::setInsert('years', $params);
            if($insert['status'] === 200){
              $result["task"] = 'saved_item';
              $result["id"] = $insert["id"];
            }else if ($insert['status'] === 400){
              throw new ValidationException ( [ 'type' => 'Invalid type parameter' ], $insert['alert'] );
            }
            break;
        case 'update': // update item
            $update = BaseModel::setUpdate('years', $params);
            if($update['status'] === 200){
              $result["task"] = 'updated_item';
              $result["id"] = $params['id'];
            }else if ($update['status'] === 400){
              throw new ValidationException ( [ 'type' => 'Invalid type parameter' ], $update['alert'] );
            }
            break;
        case 'status':   // item status change
            $update = BaseModel::setUpdate('years', $params);
            if($update['status'] === 200){
              $result['task'] = 'status_updated';
              $result['id'] = $params['id'];
              $result['status'] = $params['status'];
            }else if ($update['status'] === 400){
              throw new ValidationException ( [ 'type' => 'Invalid type parameter' ], $update['alert'].' No se pudo cambiar el estado del item' ); 
            }
            break;
        default:
          throw new ValidationException (
            [ 'type' => 'Invalid type parameter' ],
            'Tipo de tarea no encontrado'
          );  
      }

    } catch (ApiException $e) {
      throw $e;
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }  

    return $result;
  }
}
?>