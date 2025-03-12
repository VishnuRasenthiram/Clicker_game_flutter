import 'package:flutter/material.dart';
import '../models/enemy_model.dart';
import '../models/stage_model.dart';
import '../core/services/enemy_service.dart';
import '../core/services/player_service.dart';
import '../models/player_model.dart';
import '../views/victory_view.dart';

final List<Stage> stages = [
  Stage(stageNumber: 1, minLevel: 1, maxLevel: 10),
  Stage(stageNumber: 2, minLevel: 11, maxLevel: 20),
  Stage(stageNumber: 3, minLevel: 21, maxLevel: 30),
  Stage(stageNumber: 4, minLevel: 31, maxLevel: 40),
  Stage(stageNumber: 5, minLevel: 41, maxLevel: 50),
];

class EnemyViewModel extends ChangeNotifier {
  final EnemyService _enemyService = EnemyService();
  final PlayerService _playerService = PlayerService();
  List<EnemyModel> _enemies = [];

  int _currentEnemyIndex = 0;

  PlayerModel player;

  EnemyViewModel({required this.player});

  int get xpToNextStage => 50 + (currentStage * 10);
  int get xp => player.experience;
  int get currentStage => player.floor;

  EnemyModel get currentEnemy {
    if (_currentEnemyIndex >= 0 && _currentEnemyIndex < _enemies.length) {
      return _enemies[_currentEnemyIndex];
    } else {
      return _enemies.isNotEmpty ? _enemies.first : EnemyModel(name: "???", level: 1, stage: currentStage, totalLife: 100);
    }
  }

  Future<void> generateNewEnemy() async {
    final enemy = await _enemyService.generateEnemyForStage(currentStage);
    _enemies.add(enemy);
    _currentEnemyIndex = _enemies.length - 1;
    notifyListeners();
  }


  Future<void> attackEnemy(BuildContext context) async {
    if (_enemies.isEmpty) return;

    currentEnemy.reduceLife(player.damage);

    if (currentEnemy.currentLife <= 0) {

      if(currentEnemy.isBoss == 1){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VictoryScreen()),
        );
        return;
      }else {
        player.addExperience(
            currentEnemy.calculateXP().toInt());

        player.addGold(currentEnemy.calculateGold());


        if (player.experience >= xpToNextStage && player.floor < 6) {
          player.setExperience(0);

          player.advanceFloor();
          if (player.floor > stages.length) {
            final boss = await _enemyService.generateBoss();
            _enemies = [boss];
          } else {
            await generateNewEnemy();
          }
        } else {
          await generateNewEnemy();
        }
      }
      await _playerService.updatePlayer(player);
    }
    notifyListeners();
  }
}
