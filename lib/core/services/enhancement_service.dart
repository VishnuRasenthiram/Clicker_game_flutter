import '../../models/enhancement_model.dart';
import 'api_service.dart';

class EnhancementService {
  final ApiService _apiService = ApiService();


  Future<List<Enhancement>> getEnhancements() async {
    try {
      final data = await ApiService().getRequest('get_enhancements.php');
      return (data as List).map((json) => Enhancement.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des joueurs : $e');
    }

  }

  Future<List<Enhancement>> getInventoryPlayer(int playerId) async {
    try {
      final data = await ApiService().getRequest('get_enhancements.php?player_id=$playerId');
      return (data as List).map((json) => Enhancement.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des joueurs : $e');
    }

  }


  Future<void> purchaseEnhancement(int playerId, int enhancementId) async {

    final data = {
      'player_id': playerId,
      'enhancement_id': enhancementId,
    };

    try {
      await ApiService().postRequest('purchase_enhancement.php', data);
    } catch (e) {
      throw Exception('Erreur lors de l\'achat: $e');
    }

  }


  Future<void> resetEnhancements(int playerId) async {

    try {
      await ApiService().deleteRequest('purchase_enhancement.php', playerId);
    } catch (e) {
      throw Exception('Erreur lors de l\'achat: $e');
    }

  }
}