import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import '../widgets/form/player_form.dart';
import 'game_view.dart';
import '../theme.dart';

class PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des joueurs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              playerViewModel.fetchPlayers();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/player_list_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: playerViewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: playerViewModel.players.length,
          itemBuilder: (context, index) {
            final player = playerViewModel.players[index];
            return _buildWoWCard(player, context, playerViewModel);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.gold,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PlayerForm(viewModel: playerViewModel, player: null),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildWoWCard(player, BuildContext context, PlayerViewModel playerViewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.panelBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          player.pseudo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.parchment, // Texte en blanc cassé
          ),
        ),
        subtitle: Text(
          'Étage: ${player.floor}, Or: ${player.gold}, Exp: ${player.experience}',
          style: const TextStyle(color: AppTheme.parchment),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: AppTheme.blueGlow),
              onPressed: () {
                playerViewModel.selectPlayer(player);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GameView()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: AppTheme.blueGlow),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PlayerForm(viewModel: playerViewModel, player: player),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppTheme.redAccent),
              onPressed: () => playerViewModel.deletePlayer(player.id ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
