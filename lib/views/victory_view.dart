import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enhancement_viewmodel.dart';
import '../viewmodels/player_viewmodel.dart';
import 'home_view.dart';
import '../theme.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    final enhancementViewModel = Provider.of<EnhancementViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Félicitations ! Vous avez vaincu le boss final !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.gold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                playerViewModel.resetPlayer(playerViewModel.selectedPlayer!);
                enhancementViewModel.resetEnhancements(playerViewModel.selectedPlayer!);

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Quitter',
                style: TextStyle(fontSize: 18, color: AppTheme.darkBg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
