<?php
require_once('db.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["error" => "Méthode non autorisée"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
if (!$data) {
    echo json_encode(["error" => "Données JSON invalides"]);
    exit;
}


if (!isset($data['action'])) {
    echo json_encode(["error" => "Aucune action spécifiée"]);
    exit;
}

$action = $data['action'];
$response = [];

try {
    switch ($action) {
        case "insert":
            if (!isset($data['firstname'], $data['lastname'], $data['birthdate'])) {
                throw new Exception("Données insuffisantes pour l'insertion");
            }

            $query = "INSERT INTO users (firstname, lastname, birthdate) VALUES (:firstname, :lastname, :birthdate)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':firstname' => htmlspecialchars(strip_tags($data['firstname'])),
                ':lastname' => htmlspecialchars(strip_tags($data['lastname'])),
                ':birthdate' => date("Y-m-d", strtotime($data['birthdate']))
            ]);


            $response = ["success" => "Utilisateur ajouté", "id" => $db->lastInsertId()];
            break;

        case "update":
            if (!isset($data['id_user'])) {
                throw new Exception("ID manquant");
            }

            $fields = [];
            $params = [':id_user' => filter_var($data['id_user'], FILTER_VALIDATE_INT)];

            if (!empty($data['firstname'])) {
                $fields[] = "firstname = :firstname";
                $params[':firstname'] = htmlspecialchars(strip_tags($data['firstname']));
            }
            if (!empty($data['lastname'])) {
                $fields[] = "lastname = :lastname";
                $params[':lastname'] = htmlspecialchars(strip_tags($data['lastname']));
            }
            if (!empty($data['birthdate'])) {
                $fields[] = "birthdate = :birthdate";
                $params[':birthdate'] = date("Y-m-d", strtotime($data['birthdate']));
            }

            if (empty($fields)) {
                throw new Exception("Aucune donnée à modifier.");
            }

            $query = "UPDATE users SET " . implode(", ", $fields) . " WHERE id_user = :id_user";
            $stmt = $db->prepare($query);
            $stmt->execute($params);

            $response = ["success" => "Utilisateur modifié !"];
            break;

        case "delete":
            if (!isset($data['id_user'])) {
                throw new Exception("L'identifiant utilisateur est manquant.");
            }

            $query = "DELETE FROM users WHERE id_user = :id_user";
            $stmt = $db->prepare($query);
            $stmt->execute([':id_user' => filter_var($data['id_user'], FILTER_VALIDATE_INT)]);

            $response = ["success" => "Utilisateur supprimé."];
            break;

        default:
            throw new Exception("Action non reconnue");
    }
} catch (Exception $e) {
    $response = ["error" => $e->getMessage()];
}

echo json_encode($response);
