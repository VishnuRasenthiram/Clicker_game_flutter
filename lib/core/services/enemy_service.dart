import 'dart:math';
import '../../models/enemy_model.dart';
import 'api_service.dart';

class EnemyService {
  final Random _random = Random();
  final ApiService _apiService = ApiService();

  Future<List<EnemyModel>> getEnemiesForStage(int stage) async {
    try {
      final data = await _apiService.getRequest('get_enemies.php?stage=$stage');
      return (data as List).map((enemyJson) => EnemyModel.fromJson(enemyJson,stage)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des monstres : $e');
    }
  }

  Future<EnemyModel> generateEnemyForStage(int stage) async {
    if (stage == 6){
      return generateBoss();
    }
    final enemies = await getEnemiesForStage(stage);
    if (enemies.isEmpty) {
      throw Exception('Aucun monstre trouvé pour l\'étage $stage');
    }

    final randomIndex = _random.nextInt(enemies.length);
    return enemies[randomIndex];
  }


  Future<EnemyModel> generateBoss() async {
    try {
      final data = await _apiService.getRequest('get_enemies.php?stage=6');

      if (data is List) {

        final bossData = data[0];
        EnemyModel boss = EnemyModel.fromJson(bossData, 6);
        boss.setIsBoss();
        return boss;
      } else {
        throw Exception('Les données ne sont pas une liste');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des monstres : $e');
    }
  }
}