import 'package:flutter/material.dart';
import 'package:untitled1/models/player_model.dart';
import '../theme.dart';

class PlayerView extends StatelessWidget {
  final PlayerModel player;

  const PlayerView({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.panelBg,
        border: Border.all(color: AppTheme.gold, width: 3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListenableBuilder(
        listenable: player,
        builder: (context, child) {
          return Column(
            children: [
              const Text('Profil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.parchment)),
              Text(
                'Pseudo: ${player.pseudo}',
                style: TextStyle( fontWeight: FontWeight.bold, color: AppTheme.parchment),
              ),
              SizedBox(height: 8),
              Text('Étage: ${player.floor}', style: TextStyle(color: AppTheme.parchment)),
              Text('Or: ${player.gold}', style: TextStyle(color: AppTheme.parchment)),
              Text('Expérience Bonus: ${player.bonusExp}', style: TextStyle(color: AppTheme.parchment)),
              Text('Dégâts par click: ${player.damage}', style: TextStyle(color: AppTheme.parchment)),
            ],
          );
        },
      ),
    );
  }
}
