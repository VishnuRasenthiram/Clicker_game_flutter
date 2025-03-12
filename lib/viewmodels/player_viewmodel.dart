import 'package:flutter/material.dart';
import '../../models/player_model.dart';
import '../core/services/player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  List<PlayerModel> _players = [];
  PlayerModel? _selectedPlayer;

  PlayerModel? get selectedPlayer => _selectedPlayer;
  bool isLoading = false;
  String errorMessage = '';

  PlayerViewModel() {
    fetchPlayers();
  }
  List<PlayerModel> get players => _players;



  Future<void> fetchPlayers() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      _players = await PlayerService().getPlayers();
    } catch (e) {
      errorMessage = 'Erreur lors de la récupération des joueurs : $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addPlayer(PlayerModel player) async {
    try {
      await PlayerService().addPlayer(player);
      await fetchPlayers();
    } catch (e) {
      errorMessage = 'Erreur lors de l\'ajout du joueur : $e';
      notifyListeners();
    }
  }


  Future<void> updatePlayer(PlayerModel player) async {
    try {
      await PlayerService().updatePlayer(player);
      await fetchPlayers();
    } catch (e) {
      errorMessage = 'Erreur lors de la mise à jour du joueur : $e';
      notifyListeners();
    }
  }


  Future<void> deletePlayer(int id) async {
    try {
      await PlayerService().deletePlayer(id);
      await fetchPlayers();
    } catch (e) {
      errorMessage = 'Erreur lors de la suppression du joueur : $e';
      notifyListeners();
    }
  }

  Future<void> resetPlayer(PlayerModel player) async {
    try {
      player.reset();
      await PlayerService().updatePlayer(player);
      await fetchPlayers();
    } catch (e) {
      errorMessage = 'Erreur lors de la mise à jour du joueur : $e';
      notifyListeners();
    }
  }
  void selectPlayer(PlayerModel player) {
    _selectedPlayer = player;
    notifyListeners();
  }

  void clearSelectedPlayer() {
    _selectedPlayer = null;
    notifyListeners();
  }
}