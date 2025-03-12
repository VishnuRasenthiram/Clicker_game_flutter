import 'package:flutter/material.dart';
import '../core/services/player_service.dart';
import '../models/enhancement_model.dart';
import '../models/player_model.dart';
import '../core/services/enhancement_service.dart';

class EnhancementViewModel extends ChangeNotifier {
  final EnhancementService _enhancementService = EnhancementService();
  final PlayerService _playerService = PlayerService();
  final PlayerModel player;
  List<Enhancement> _enhancements = [];
  List<Enhancement> _inventory = [];
  bool _isLoading = false;
  String _errorMessage = '';

  EnhancementViewModel({required this.player}) {
    loadEnhancements();
    loadInventory();
  }

  List<Enhancement> get enhancements => _enhancements;
  List<Enhancement> get inventory => _inventory;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;


  Future<void> loadEnhancements() async {
    _isLoading = true;
    notifyListeners();

    try {
      _enhancements = await _enhancementService.getEnhancements();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des améliorations : $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  int calculateTotalEnhancementValue(List<Enhancement> inventory, String type) {
    return inventory
        .where((enhancement) => enhancement.nameType == type)
        .fold(0, (sum, enhancement) => sum + enhancement.boostValue);
  }


  Future<void> loadInventory() async {
    try {
      _inventory = await _enhancementService.getInventoryPlayer(player.id);
      int totalXp = calculateTotalEnhancementValue(_inventory, 'exp');
      int totalDamage = calculateTotalEnhancementValue(_inventory, 'dps');
      player.setDamage(1+totalDamage);
      player.setBonusExperience(totalXp);

      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement de l\'inventaire : $e';
    }
  }

  bool canPurchaseEnhancement(Enhancement enhancement) {
    return player.gold >= enhancement.goldCost;
  }

  Future<String> purchaseEnhancement(Enhancement enhancement) async {


    if (inventory.any((e) => e.id == enhancement.id)) {
      return 'Vous possédez déjà cet amélioration';
    }
    if (!canPurchaseEnhancement(enhancement)) {
      return 'Pas assez d\'or pour acheter cet amélioration';
    }else{
      try {
        await _enhancementService.purchaseEnhancement(player.id, enhancement.id);
        player.looseGold(enhancement.goldCost);
        _inventory.add(enhancement);
        loadInventory();
        await _playerService.updatePlayer(player);
        notifyListeners();
        return 'Achat réussi !';
      } catch (e) {
        return 'Erreur lors de l\'achat : $e';
      }
    }

  }
  Future<void> resetEnhancements(PlayerModel player) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _enhancementService.resetEnhancements(player.id);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des améliorations : $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
