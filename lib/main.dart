import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/config.dart';
import 'models/player_model.dart';
import 'viewmodels/player_viewmodel.dart';
import 'viewmodels/enemy_viewmodel.dart';
import 'viewmodels/enhancement_viewmodel.dart';
import 'views/home_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerViewModel()),
        ChangeNotifierProxyProvider<PlayerViewModel, EnemyViewModel>(
          create: (context) => EnemyViewModel(player: PlayerModel()),
          update: (context, playerViewModel, enemyViewModel) {
            return EnemyViewModel(player: playerViewModel.selectedPlayer ?? PlayerModel());
          },
        ),
        ChangeNotifierProxyProvider<PlayerViewModel, EnhancementViewModel>(
          create: (context) => EnhancementViewModel(player: PlayerModel()),
          update: (context, playerViewModel, enhancementViewModel) {
            return EnhancementViewModel(player: playerViewModel.selectedPlayer ?? PlayerModel());
          },
        ),
      ],
      child: MaterialApp(
        title: 'World Of Clicker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Home(),
      ),
    );
  }
}