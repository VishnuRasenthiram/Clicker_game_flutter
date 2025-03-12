import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enemy_viewmodel.dart';
import '../theme.dart';

class EnemyWidget extends StatefulWidget {
  const EnemyWidget({super.key});

  @override
  State<EnemyWidget> createState() => _EnemyWidgetState();
}

class _EnemyWidgetState extends State<EnemyWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<EnemyViewModel>(context, listen: false);
      viewModel.generateNewEnemy();
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<EnemyViewModel>();
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Étage: ${viewModel.currentStage}', style: TextStyle(color: AppTheme.parchment)),
          Text('XP: ${viewModel.xp} / ${viewModel.xpToNextStage}', style: TextStyle(color: AppTheme.parchment)),
          GestureDetector(
            onTap: () {
              if (viewModel.currentEnemy.currentLife > 0) {
                viewModel.attackEnemy(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.gold, width: 3),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.gold.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/enemies/${viewModel.currentStage}/enemy_${viewModel.currentEnemy.name}.png',
                width: 200,
                height: 200,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/enemies/1/enemy_Gnoll.png',
                    width: 300,
                    height: 300,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Ennemi: ${viewModel.currentEnemy.name}', style: TextStyle(color: AppTheme.parchment)),
          Text('Niveau: ${viewModel.currentEnemy.level}', style: TextStyle(color: AppTheme.parchment)),
          Text('Vie: ${viewModel.currentEnemy.currentLife} / ${viewModel.currentEnemy.totalLife}', style: TextStyle(color: AppTheme.parchment)),
        ],
      ),
    );
  }
}
