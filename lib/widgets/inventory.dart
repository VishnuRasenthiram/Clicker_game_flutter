import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enhancement_viewmodel.dart';
import '../theme.dart';

class Inventory extends StatelessWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enhancementViewModel = Provider.of<EnhancementViewModel>(context);

    if (enhancementViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Inventaire',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.parchment,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: enhancementViewModel.inventory.length,
            itemBuilder: (context, index) {
              final enhancement = enhancementViewModel.inventory[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.gold, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gold.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(enhancement.name, style: TextStyle(color: AppTheme.parchment)),
                  subtitle: Text(
                    '+ ${enhancement.boostValue} ${enhancement.nameType}',
                    style: TextStyle(color: AppTheme.parchment),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
