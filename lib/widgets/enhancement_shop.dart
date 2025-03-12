import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enhancement_viewmodel.dart';
import '../theme.dart';

class EnhancementShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final enhancementViewModel = Provider.of<EnhancementViewModel>(context);

    return Container(
      width: 200,
      color: AppTheme.panelBg,
      child: Column(
        children: [
          const Text('Magasin d\'Améliorations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold)),
          if (enhancementViewModel.isLoading)
            const CircularProgressIndicator()
          else if (enhancementViewModel.errorMessage.isNotEmpty)
            Text(
              enhancementViewModel.errorMessage,
              style: const TextStyle(color: AppTheme.redAccent),
            )
          else
            SizedBox(
              height: 600,
              child: ListView.builder(
                itemCount: enhancementViewModel.enhancements.length,
                itemBuilder: (context, index) {
                  final enhancement = enhancementViewModel.enhancements[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.gold, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gold.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(enhancement.name, style: TextStyle(color: AppTheme.parchment)),
                      subtitle: Text(
                        '+ ${enhancement.boostValue} ${enhancement.nameType} \nCoût : ${enhancement.goldCost} or',
                        style: TextStyle(color: AppTheme.parchment),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.shopping_cart, color: AppTheme.gold),
                        onPressed: () async {
                          String result = await enhancementViewModel.purchaseEnhancement(enhancement);
                          if (context.mounted) {
                            _showPurchaseResultDialog(context, result);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showPurchaseResultDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Résultat de l\'achat', style: TextStyle(color: Colors.black)),
          content: Text(message, style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK', style: TextStyle(color: AppTheme.gold)),
            ),
          ],
        );
      },
    );
  }
}
