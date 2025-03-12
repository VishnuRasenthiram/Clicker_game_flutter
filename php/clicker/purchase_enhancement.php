<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once('db.php'); 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');
    
    try {
       
        $data = json_decode(file_get_contents('php://input'), true);
        
        if ($data === null) {
            throw new Exception("Données JSON invalides", 400);
        }
        
        if (!isset($data['player_id'], $data['enhancement_id'])) {
            throw new Exception("Données manquantes : player_id et enhancement_id sont requis", 400);
        }
        
        $playerId = (int) $data['player_id'];
        $enhancementId = (int) $data['enhancement_id'];
        
       
        $stmt = $db->prepare("SELECT gold FROM Player WHERE id_player = :player_id");
        $stmt->execute([':player_id' => $playerId]);
        $player = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$player) {
            throw new Exception("Joueur non trouvé", 404);
        }
    
        
        $stmt = $db->prepare("SELECT gold_cost FROM enhancement WHERE id_enhancement = :enhancement_id");
        $stmt->execute([':enhancement_id' => $enhancementId]);
        $enhancement = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$enhancement) {
            throw new Exception("Objet non trouvé", 404);
        }
        
       

        $db->beginTransaction();
        
        

        $stmt = $db->prepare("INSERT IGNORE INTO Buy (id_player, id_enhancement) VALUES (:player_id, :enhancement_id)");
        $stmt->execute([
            ':player_id' => $playerId,
            ':enhancement_id' => $enhancementId,
        ]);

        

        $db->commit();
        
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        if ($db->inTransaction()) {
            $db->rollBack();
        }
        http_response_code($e->getCode() ?: 500);
        echo json_encode(["error" => $e->getMessage()]);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {

    $id = $_GET['id'];

    if ($id) {
        try {

            $query = "DELETE FROM Buy WHERE id_player = :id";
            $stmt = $db->prepare($query);
            $stmt->execute([':id' => $id]);


            echo json_encode(["success" => true, "message" => "Joueur supprimé avec succès"]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["error" => "ID du joueur manquant"]);
    }
} 