<?php
  require_once "models/ModelsBD.php";
  require_once "response.php";
  class map extends ModelsBD {
    public function __construct(){}
    //--------------------private access------------------------------------------- 
    private static function buildInClause(string $field, array $values, array &$params): string {
        if (empty($values)) {
            return '';
        }

        $placeholders = [];
        foreach ($values as $index => $value) {
            $key = "{$field}_{$index}";
            $placeholders[] = ":{$key}";
            $params[$key] = $value;
        }

        return " AND {$field} IN (" . implode(',', $placeholders) . ")";
    }
    //--------------------public access-------------------------------------------        
    static public function _getIndicators(){
        $return = new response();
        $result = array();

        $query = "SELECT i.`id`, i.`name` AS `title`, i.`team` 
          FROM `indicators` i
          WHERE i.`map` = 1 AND i.`status` = 1 
          ORDER BY i.`name` ASC;"; 
        $Items_BD = ModelsBD::getFilter($query);
    
        if (empty($Items_BD)) {
          return $return->setResponse(null, '¡items not found!', 400);
        }

        $indicatorsIds = array_column($Items_BD, 'id'); // Prepara una lista de ids de módulos para la consulta de submódulos
        $indicatorsIdsList = implode(',', $indicatorsIds); // Realiza una consulta para obtener todos los submódulos de una vez
        
        $subIndicatorsQuery = "SELECT `id`, `indicator_id`, `name` AS `title`
                            FROM `indicator_categories`
                            WHERE `indicator_id` IN ($indicatorsIdsList) AND `status` = 1;";
        $subIndicators_BD = ModelsBD::getFilter($subIndicatorsQuery);

        return $return->setResponse($subIndicators_BD, null, null);

        $subIndicatorsById = [];
        foreach ($subIndicators_BD as $subM) {
          $subIndicatorsById[$subM['id_mod']][] = [
              'id' => $subM['id'],
              'title' => $subM['title'],
              // 'color' => $subM['color'],
              // 'icon' => $subM['icon'],
              // 'search' => $subM['search'],
              // 'id_search' => $subM['id_search'],
              // 'items' => [],
              'uri' => '', // Puedes configurar esto si es necesario
          ];
        }

      //  foreach ($Items_BD as $item) {
      //     $newItem = [
      //        'id' => $item['id'],
      //        'title' => $item['title'],
      //        'items' => [],
      //        'uri' => $item['uri'],
      //        'icon' => $item['icon'],
      //        'color' => $item['color'],
      //        'team' => $item['team'],
      //     ];

      //     // if ($item['team'] == 1 && isset($subModulesById[$item['id']])) {
      //     //       $newItem['sub_modules'] = $subModulesById[$item['id']];
      //     // }

      //     if ($item['team'] == 1 && isset($subModulesById[$item['id']])) {
      //        foreach ($subModulesById[$item['id']] as &$subM) {
      //            $subM['uri'] = $item['uri'];
      //        }
      //        $newItem['sub_modules'] = $subModulesById[$item['id']];
      //    }

      //     $result[] = $newItem;
      //  }

      //  return $return->setResponse($result, null, null);

    }
    //----------------------------------------------------------------------------
    static public function getIndicators(){
        $return = new response();
        // $result = array();

        $query = 
        "SELECT i.id, i.name AS title
        FROM indicators i
        INNER JOIN indicator_categories ic 
            ON ic.indicator_id = i.id
            AND ic.status = ?
        WHERE i.status = ?
        GROUP BY i.id, i.name
        ORDER BY i.name ASC;";

        $items = self::setQuery($query, [1, 1], 'all');
    
        if (empty($items)) {
          return $return->setResponse(null, '¡items not found!', 400);
        }

        return $return->setResponse($items, null, null);

    }
    static public function getIndicatorCategories($indicatorId){
        $return = new response();
        $result = array();

        $query = 
        "SELECT ic.id, ic.name AS title
        FROM indicator_categories ic
        WHERE ic.indicator_id = ? 
            AND ic.status = ?
        ORDER BY ic.name ASC;";

        // $params = array($indicatorId);
        $items = self::setQuery($query, [$indicatorId, 1], 'all');
    
        if (empty($items)) {
          return $return->setResponse(null, '¡items not found!', 400);
        }

        return $return->setResponse($items, null, null);
    }
    static public function getYears(){
      $return = new response();
      $result = array();

      $query = 
      "SELECT y.id, y.name AS title
      FROM years y
      WHERE y.status = ?
      ORDER BY y.name DESC;";

      $items = self::setQuery($query, [1], 'all');
  
      if (empty($items)) {
        return $return->setResponse(null, '¡items not found!', 400);
      }

      return $return->setResponse($items, null, null);
    }
    static public function getStates(){
      $return = new response();
      $result = array();

      $query = 
      "SELECT s.id, s.name AS title
      FROM states s
      WHERE s.status = ? AND s.country_id = ?
      ORDER BY s.name ASC;";

      $items = self::setQuery($query, [1, 1], 'all');
  
      if (empty($items)) {
        return $return->setResponse(null, '¡items not found!', 400);
      }

      return $return->setResponse($items, null, null);
    }
    static public function getGenders(){
      $return = new response();
      $result = array();

      $query = 
      "SELECT g.id, g.name AS title
      FROM genders g
      WHERE g.status = ?
      ORDER BY g.name ASC;";

      $items = self::setQuery($query, [1], 'all');
  
      if (empty($items)) {
        return $return->setResponse(null, '¡items not found!', 400);
      }

      return $return->setResponse($items, null, null);
    }
    static public function getDataIndicators($data){
      $return = new response();
      $result = array();

      // $query = "
      //   SELECT
      //     icd.indicator_category_id AS category_id,
      //     ic.name AS category_name,

      //     icd.year_id,
      //     y.name AS year_name,

      //     icd.gender_id,
      //     g.name AS gender_name,

      //     icd.center_id AS state_id,
      //     s.name AS state_name,

      //     icd.quantity
      //   FROM indicator_category_details icd
      //   INNER JOIN indicator_categories ic ON ic.id = icd.indicator_category_id
      //   INNER JOIN years y ON y.id = icd.year_id
      //   INNER JOIN genders g ON g.id = icd.gender_id
      //   INNER JOIN states s ON s.id = icd.center_id
      //   WHERE icd.status = 1
      // ";
      $query = "Hola Mundo";
      $params = [];

      // Construcción dinámica de filtros
      // if (!empty($data['category_id'])) {
      //     $query .= self::buildInClause('icd.indicator_category_id', $data['category_id'], $params);
      // }

      return $return->setResponse($query, null, null);

      // --------------------------------------------------------------------------------------
      // $items = self::setQuery($query, [1], 'all');
  
      // if (empty($items)) {
      //   return $return->setResponse(null, '¡items not found!', 400);
      // }

      // return $return->setResponse($items, null, null);
    }
    static public function getDataIndicatorsv2($data){
      $return = new response();
      $result = array();

      $query = 
      "SELECT g.id, g.name AS title
      FROM genders g
      WHERE g.status = ?
      ORDER BY g.name ASC;";

      $items = self::setQuery($query, [1], 'all');
  
      if (empty($items)) {
        return $return->setResponse(null, '¡items not found!', 400);
      }

      return $return->setResponse($items, null, null);
    }

  }

?>