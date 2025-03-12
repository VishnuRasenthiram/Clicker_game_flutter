import 'package:flutter/material.dart';
import '../../models/player_model.dart';
import '../../viewmodels/player_viewmodel.dart';

class PlayerForm extends StatefulWidget {
  final PlayerViewModel viewModel;
  final PlayerModel? player;

  const PlayerForm({super.key, required this.viewModel, this.player});

  @override
  PlayerFormState createState() => PlayerFormState();
}

class PlayerFormState extends State<PlayerForm> {
  late TextEditingController pseudoController;
  late TextEditingController floorController;
  late TextEditingController goldController;
  late TextEditingController experienceController;

  @override
  void initState() {
    super.initState();
    pseudoController = TextEditingController(text: widget.player?.pseudo ?? '');
    floorController = TextEditingController(text: widget.player?.floor.toString() ?? '1');
    goldController = TextEditingController(text: widget.player?.gold.toString() ?? '0');
    experienceController = TextEditingController(text: widget.player?.experience.toString() ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.player == null ? "Ajouter un joueur" : "Modifier le joueur"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: pseudoController, decoration: const InputDecoration(labelText: "Pseudo"))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            if (pseudoController.text.isNotEmpty) {

              final player = PlayerModel(
                id: widget.player?.id ?? 0,
                pseudo: pseudoController.text,
                floor: int.parse(floorController.text),
                gold: int.parse(goldController.text),
                experience: int.parse(experienceController.text),
              );

              if (widget.player == null) {

                widget.viewModel.addPlayer(player);
              } else {

                widget.viewModel.updatePlayer(player);
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.player == null ? "Ajouter" : "Modifier"),
        ),
      ],
    );
  }
}