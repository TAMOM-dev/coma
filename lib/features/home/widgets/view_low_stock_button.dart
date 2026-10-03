import 'package:flutter/material.dart';

class ViewLowStockButton extends StatelessWidget{
  final VoidCallback onPressed;
  const ViewLowStockButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text('Ver productos agotados'),
    );
  }
}