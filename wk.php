<?php
session_start();
error_reporting(-1);
ini_set('display_errors', 'On');

$db = new PDO('mysql:host=localhost;dbname=localgaming', 'root', '');
$sql = "SELECT Produkt_ID, P_Name, P_Zustand, P_Preis, Beschreibung, Konsole_ID, Cart_ID FROM produkt";

$shopurl = $_SERVER['REQUEST_URI'];
var_dump($shopurl);

$result = $db->query($sql);

$userID = random_int(0,time());
$cartItems = 0;

if(isset($_COOKIE['userID'])){
    $userID = (int) $_COOKIE['userID'];
}
if(isset($_SESSION['userID'])){
    $userID = (int) $_SESSION['userID'];
}

setcookie('userID', $userID, strtotime('+30 days'));
var_dump($userID);

$sqlwk = "SELECT COUNT(Cart_ID) FROM Warenkorb WHERE Nutzer_ID =".$userID;
$cartResults = $db->query($sqlwk);

$cartItems = $cartResults->fetchColumn();

$sqlwk = "SELECT Cart_ID, Nutzer_ID, erstellt, Produkt_ID FROM warenkorb";
$del = $db->query($sqlwk); 
$row = $del->fetch();

$sql = "  SELECT p.P_Name, p.P_Preis, w.Produkt_ID
          FROM warenkorb w, produkt p
          WHERE w.Produkt_ID = p.Produkt_ID
          AND w.Nutzer_ID = $userID;
        ";
$result = $db->query($sql);

$sqlpreis = " SELECT SUM(p.P_Preis) AS Gesamtpreis
              FROM produkt p, warenkorb w
              WHERE p.Produkt_ID = w.Produkt_ID
              AND w.Cart_ID = w.Produkt_ID
            ";
$gesamtpreis = $db->query($sqlpreis);
$gpeinkauf = $gesamtpreis->fetch();

$wkPosition = strpos($shopurl, 'wk.php');
$route = substr($shopurl, $wkPosition);
$route = str_replace('wk.php', '', $route);

if(strpos($route, '/cart/del/') !== false){
  $routeParts = explode("/", $route);
  $productID = (int)$routeParts[3];

  $statement = $db->prepare("DELETE FROM warenkorb WHERE Produkt_ID = $productID;");
  $statement->execute();

  header("Location: /Projekte/LocalGaming/wk.php");
  exit();
  
}


require __DIR__ . '/Template/header.php';
echo "<h2>Willkommen im Warenkorb</h2>
";
?>
    <section class="containerwkc" id="produkte" style="margin-bottom: -30px;">
        <?php include 'Template/gesamtpreis.php' ?>
      <div class="row">
        <?php while($row = $result->fetch()): ?>
          <div class="colwk">
              <?php include 'Template/warenkorbkarte.php' ?>
            </div>
          <?php endwhile;?>
      </div>
    </section>
    <a href="#" class="up">Nach oben?</a>
    </body>
</html>