import 'package:flutter/material.dart';
import 'player_list_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerListView(),
    );
  }
}