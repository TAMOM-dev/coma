import 'package:coma/features/home/widgets/view_low_stock_button.dart';
import 'package:flutter/material.dart';

class InfoPanelCard extends StatelessWidget{
  const InfoPanelCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: theme.colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //*Card information
            children: [
              Text('Productos fuera de stock', style: TextStyle(color: theme.colorScheme.onPrimaryContainer),),
              const SizedBox(height: 8),
              Text(
                '14',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              //*Out of stock Button
              Center(
                child: ViewLowStockButton(onPressed: (){
                  //TODO: Add view button implementation
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}