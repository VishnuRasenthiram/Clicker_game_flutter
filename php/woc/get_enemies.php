<?php
require_once('db.php');


if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $stage = $_GET['stage'];

    if ($stage) {
        try {

            $query = "SELECT * FROM Enemy WHERE floor = :stage";
            $stmt = $db->prepare($query);
            $stmt->execute([':stage' => $stage]);
            $enemies = $stmt->fetchAll(PDO::FETCH_ASSOC);


            echo json_encode($enemies);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["error" => "Étage manquant"]);
    }
} else {
    http_response_code(405);
    echo json_encode(["error" => "Méthode non autorisée"]);
}
?>