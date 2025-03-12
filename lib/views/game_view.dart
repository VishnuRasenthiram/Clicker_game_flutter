import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import '../widgets/enhancement_shop.dart';
import '../widgets/inventory.dart';
import '../widgets/enemy_widget.dart';
import '../views/player_view.dart';
import '../theme.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.selectedPlayer;

    if (player == null) {
      Navigator.pop(context);
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('World Of Clicker'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/game_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [

                  _buildPanel(child: PlayerView(player: player), width: 250),
                  _buildPanel(child: Inventory(), width: 300),
                  _buildPanel(child: const EnemyWidget(), width: 300),
                  _buildPanel(child: EnhancementShop(), width: 350),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel({required Widget child, double? width}) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.panelBg,
        border: Border.all(color: AppTheme.gold, width: 3),
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("assets/frames/panel_texture.jpg"),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}
