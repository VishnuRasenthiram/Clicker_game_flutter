<?php
require_once('db.php');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Accept"); // Inclure le fichier de connexion à la base de données

// Vérifier la méthode HTTP
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Vérifier si l'ID du joueur est passé dans les paramètres de l'URL
    if (isset($_GET['id_player'])) {
        $id_player = $_GET['id_player'];
        $response = [];

        try {
            // Requête pour récupérer les informations du joueur avec l'ID donné
            $query = "SELECT * FROM Player WHERE id_player = :id_player";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_player' => $id_player]);
            $player = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($player) {
                // Si le joueur est trouvé, renvoyer ses données
                $response = [
                    'id_player' => $player['id_player'],
                    'pseudo' => $player['pseudo'],
                    'floor' => $player['floor'],
                    'gold' => $player['gold'],
                    'experience' => $player['experience']
                ];
            } else {
                // Si le joueur n'existe pas
                $response = ["error" => "Joueur non trouvé"];
            }

        } catch (Exception $e) {
            // Gestion des erreurs
            http_response_code(500);
            $response = ["error" => "Erreur serveur : " . $e->getMessage()];
        }

        // Retourner la réponse en format JSON
        echo json_encode($response);

    } else {
        // Si le paramètre id_player n'est pas passé, récupérer tous les joueurs
        try {
            $query = "SELECT * FROM Player"; // Requête pour récupérer tous les joueurs
            $stmt = $db->prepare($query);
            $stmt->execute();
            $players = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($players) {
                // Si des joueurs sont trouvés, renvoyer leurs données
                echo json_encode($players);
            } else {
                // Si aucun joueur n'est trouvé
                echo json_encode(["error" => "Aucun joueur trouvé"]);
            }

        } catch (Exception $e) {
            // Gestion des erreurs
            http_response_code(500);
            echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
        }
    }

} 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['pseudo']) && isset($data['floor']) && isset($data['gold']) && isset($data['experience'])) {
        $pseudo = $data['pseudo'];
        $floor = $data['floor'];
        $gold = $data['gold'];
        $experience = $data['experience'];

        try {
            // Requête pour insérer un nouveau joueur
            $query = "INSERT INTO Player (pseudo, floor, gold, experience) VALUES (:pseudo, :floor, :gold, :experience)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':pseudo' => $pseudo,
                ':floor' => $floor,
                ':gold' => $gold,
                ':experience' => $experience,
            ]);

            // Retourner une réponse JSON
            echo json_encode(["success" => true, "message" => "Joueur ajouté avec succès"]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["error" => "Données manquantes"]);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {

    $id = $_GET['id'];

    if ($id) {
        try {

            $query = "DELETE FROM Player WHERE id_player = :id";
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

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {

    $id = $_GET['id'];
    $data = json_decode(file_get_contents('php://input'), true);

    if ($id && isset($data['pseudo']) && isset($data['floor']) && isset($data['gold']) && isset($data['experience'])) {
        $pseudo = $data['pseudo'];
        $floor = $data['floor'];
        $gold = $data['gold'];
        $experience = $data['experience'];

        try {
  
            $query = "UPDATE Player SET pseudo = :pseudo, floor = :floor, gold = :gold, experience = :experience WHERE id_player = :id";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':pseudo' => $pseudo,
                ':floor' => $floor,
                ':gold' => $gold,
                ':experience' => $experience,
                ':id' => $id,
            ]);


            echo json_encode(["success" => true, "message" => "Joueur mis à jour avec succès"]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["error" => "Données manquantes ou invalides"]);
    }
}
?>