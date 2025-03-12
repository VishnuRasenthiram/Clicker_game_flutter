import '../../models/player_model.dart';
import 'api_service.dart';

class PlayerService {

  Future<List<PlayerModel>> getPlayers() async {
    try {
      final data = await ApiService().getRequest('player.php');
      return (data as List).map((playerJson) => PlayerModel.fromJson(playerJson)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des joueurs : $e');
    }
  }


  Future<void> addPlayer(PlayerModel player) async {
    final data = {
      'pseudo': player.pseudo,
      'floor': player.floor,
      'gold': player.gold,
      'experience': player.experience,
    };
    try {
      await ApiService().postRequest('player.php', data);
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du joueur : $e');
    }
  }

  Future<void> updatePlayer(PlayerModel player) async {
    try {
      await ApiService().updateRequest('player.php', player.id ?? 0, player.toJson());
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du joueur : $e');
    }
  }


  Future<void> deletePlayer(int id) async {
    try {
      await ApiService().deleteRequest('player.php', id);
    } catch (e) {
      throw Exception('Erreur lors de la suppression du joueur : $e');
    }
  }

}