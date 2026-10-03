import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ModuleHeader extends StatelessWidget {
  final String mainTitle;
  final String accentTitle;
  final String description;
  const ModuleHeader({
    super.key,
    required this.mainTitle,
    required this.accentTitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: theme.textTheme.titleLarge,
            children: [
              TextSpan(text: '$mainTitle\n'),
              TextSpan(
                text: '$accentTitle\n',
                style: TextStyle(color: AppColors.primary)
              ),
              TextSpan(
                text: description,
                style: theme.textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ],
    );
  }
}
