import 'package:flutter/material.dart';

class StatPanel extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;   
  final IconData? trailingIcon; 
  final bool highlighted;    

  const StatPanel({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.trailingIcon,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: highlighted
            ? BorderSide(color: theme.colorScheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    color: valueColor ?? theme.colorScheme.onSurface,
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(trailingIcon, size: 20, color: theme.colorScheme.primary),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}