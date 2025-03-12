import 'dart:math';
class EnemyModel {
  final String name;
  final int level;
  final int stage;
  final int totalLife;
  int currentLife;
  int _isBoss = 0;


  EnemyModel({
    required this.name,
    required this.level,
    required this.stage,
    required this.totalLife,
  }) : currentLife = totalLife;


  factory EnemyModel.fromJson(Map<String, dynamic> json, int stage) {
    final random = Random();
    int level = _generateLevelForStage(stage, random);

    return EnemyModel(
      name: json['name'],
      level: level,
      stage: stage,
      totalLife: _calculateTotalLife(level, stage),
    );
  }


  static int _generateLevelForStage(int stage, Random random) {
    int minLevel = (stage - 1) * 10 + 1;
    int maxLevel = stage * 10;

    if (stage == 6){
      return 100;
    }

    return random.nextInt(maxLevel - minLevel + 1) + minLevel;
  }


  static int _calculateTotalLife(int level, int stage) {
    int baseHP = 10;
    int scaleFactor = 5;
    int stageBonus = 15;
    return baseHP + (level * scaleFactor) + (stage * stageBonus);
  }
  void reduceLife(int damage) {
    currentLife = (currentLife - damage).clamp(0, totalLife);
  }
  int calculateXP() {
    int baseXP = 10;
    double levelFactor = 1.0 + (level - 1) * 0.1;
    double stageFactor = 1.0 + (stage - 1) * 0.1;
    return (baseXP * levelFactor * stageFactor).toInt();
  }
  int calculateGold() {
    return level * 5;
  }

  void setIsBoss(){
    _isBoss = 1;
  }

  int get isBoss => _isBoss;
}
