<?php
require_once('db.php'); 

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        if (isset($_GET['player_id'])) {
           
            $query = "
                SELECT e.id_enhancement,e.nom, e.gold_cost, e.boost_value, e.id_type, t.name_type
                FROM Buy b
                JOIN enhancement e ON b.id_enhancement = e.id_enhancement
                JOIN type_enhancement t ON e.id_type = t.id_type
                WHERE b.id_player = :player_id
            ";
            $stmt = $db->prepare($query);
            $stmt->execute([':player_id' => $_GET['player_id']]);
            $enhancements = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
           
            $query = "
                SELECT e.id_enhancement,e.nom, e.gold_cost, e.boost_value, e.id_type, t.name_type
                FROM enhancement e
                JOIN type_enhancement t ON e.id_type = t.id_type
            ";
            $stmt = $db->prepare($query);
            $stmt->execute();
            $enhancements = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }


        header('Content-Type: application/json');
        echo json_encode($enhancements);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
    }
}
?>
