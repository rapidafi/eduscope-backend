<?php
// just in case
require 'http_response_code.php';

$headers = array();
$headers[]='Access-Control-Allow-Headers: Content-Type';
$headers[]='Access-Control-Allow-Methods: OPTIONS, GET';
$headers[]='Access-Control-Max-Age: 1728000';
if (isset($_SERVER['REQUEST_METHOD'])) {
  foreach ($headers as $header) header($header);
} else {
  echo json_encode($headers);
}
header('Content-Type: application/json; charset=utf-8');

// get the HTTP method, path and body of the request
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'OPTIONS') {
  http_response_code(200);
  exit;
}
if ($method != 'GET') {
  http_response_code(405);
  exit;
}

$request = array();
if (isset($_SERVER['PATH_INFO'])) {
  $request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
}
$input = json_decode(file_get_contents('php://input'),true);

$dbschema = "";
if (isset($_GET['version'])) {
  $dbschema = $_GET['version'];
}
$sort = "1";
if (isset($_GET['sort'])) {
  $sort = preg_replace('/[^-+a-z0-9_]+/i','',$_GET['sort']); // nb! - and + chars
}
$limit = 1000;
if (isset($_GET['limit']) && (is_numeric($_GET['limit']) || strtoupper($_GET['limit']) == 'ALL')) {
  $limit = $_GET['limit'];
}
if (is_numeric($limit) && ($limit<1 || $limit>1000)) {
  $limit = 1000;
}
$offset = 0;
if (isset($_GET['offset']) && is_numeric($_GET['offset'])) {
  $offset = $_GET['offset'];
}
if ($offset<1) {
  $offset = 0;
}

// TODO get database connection settings
$settings = parse_ini_file('/opt/vault.ini', true);
try {
  $dbhost = $settings['database']['host'];
  $dbname = $settings['database']['name'];
  $dbuser = $settings['database']['user'];
  $dbpass = $settings['database']['pass'];
  $dbh = new PDO("pgsql: host=$dbhost; dbname=$dbname", $dbuser, $dbpass);
} catch (PDOException $e) {
  die("Something went wrong while connecting to database: " . $e->getMessage() );
}
// oh hack: get schema name from this script filename: $dbschema = 'v201711';
// => parameterized. should not be needed anymore!
if ($dbschema=="") {
  $dbschema = split(".php",split("_",basename(__FILE__),2)[1],2)[0];
}

// special case for listing datasets
if (count($request)<=1 && (empty($request) || empty($request[0]))) {
  $sql = "SELECT TABLE_NAME as name FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=?";
  $params = array($dbschema);
} else {
  // retrieve the table name from the path
  $table = preg_replace('/[^a-z0-9_]+/i','',array_shift($request));
  // escape the columns and values from the input object (in the form of /column=value/column2=value2/...)
  $parts = !$request ? null : array_map(function ($value) use ($dbh) {
    if ($value===null) return null;
    // escape str
    $value = stripslashes($value);
    $value = str_replace("'","''",$value);
    $value = str_replace("\0","[NULL]",$value);
    return $value;
  },array_values($request));
  $columns=array();
  $params=array();
  if ($parts !== null) {
    foreach ($parts as $part) {
      list($column,$value) = explode("=",$part,2);
      array_push($columns,$column);
      array_push($params,$value);
    }
  }
  // create SQL statement
  $sql = "SELECT * FROM \"$dbschema\".\"$table\" WHERE 1=1";
  for ($i=0; $i<count($columns); $i++) {
    $sql.= " AND \"".$columns[$i]."\"=?";
  }
  $sql.= " ORDER BY $sort"; // prepared statement wont work but injection solved by character allowance
  $sql.= " LIMIT $limit";
  array_push($params,$offset);
  $sql.= " OFFSET ?";
}
// excecute SQL statement
$sth = $dbh->prepare($sql,array(PDO::ATTR_CURSOR => PDO::CURSOR_SCROLL));
if (empty($params)) {
  $sth->execute();
} else {
  $sth->execute($params);
}
// print results (loop thru to avoid memory issues)
echo "[";
$num = 0;
while (($row = $sth->fetch(PDO::FETCH_ASSOC, PDO::FETCH_ORI_NEXT)) !== FALSE) {
  if ($num++ > 0) { echo ","; }
  echo json_encode($row);//,JSON_NUMERIC_CHECK);
}
echo "]";
// clean up & close
$sth = null;
$dbh = null;
?>
