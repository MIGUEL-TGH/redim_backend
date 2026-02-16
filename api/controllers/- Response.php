<?php
   class response {
      public function setResponse($data, $error, $status){
         if(!empty($data)){
            $result = array(
               'status' => 200,
               'total' => (is_array($data)) ? count($data) : 1,
               'result' => $data,
            );
         }else{
            if($error == null){
               $result = array(
                  'status' => 404,
                  'result' => 'Result Not Found',
               );
            }
            else{
               $result = array(
                  'status' => $status,
                  'result' => 'Error --> '.$error,
               );
            }
         }
         echo json_encode($result, http_response_code($result['status']));
      }
  }
?>