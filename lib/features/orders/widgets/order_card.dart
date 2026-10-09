import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/core/utils/formatters.dart';
import 'package:coma/data/models/order.dart';
import 'package:flutter/material.dart';

//* Order panel: compact summary, tap to expand details
class OrderCard extends StatelessWidget {
  final Order order;
  final bool expanded;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OrderCard({
    super.key,
    required this.order,
    required this.expanded,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: expanded ? BorderSide(color: theme.colorScheme.primary, width: 1.5) : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Summary
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.supplier,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 6),
                        _IconText(icon: Icons.calendar_today, text: Formatters.date(order.deliveryDate)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    Formatters.price(order.total),
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20, color: AppColors.primary),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.keyboard_arrow_down, color: theme.colorScheme.primary),
                  ),
                ],
              ),

              //* Details
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: expanded ? _details(theme) : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details(ThemeData theme) {
    final sectionStyle = theme.textTheme.bodyMedium?.copyWith(fontSize: 13, fontWeight: FontWeight.w600);
    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(fontSize: 16, color: AppColors.onSurface);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.08)),
        const SizedBox(height: 8),
        Text('PRODUCTOS (${order.products.length})', style: sectionStyle),
        const SizedBox(height: 8),
        for (final (index, product) in order.products.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('${index + 1}. $product', style: bodyStyle),
          ),
        const SizedBox(height: 12),
        _IconText(icon: Icons.payments_outlined, text: 'Total: ${Formatters.price(order.total)}'),
        const SizedBox(height: 6),
        _IconText(icon: Icons.local_shipping_outlined, text: 'Entrega: ${Formatters.date(order.deliveryDate)}'),
        if (order.notes != null) ...[
          const SizedBox(height: 16),
          Text('NOTAS', style: sectionStyle),
          const SizedBox(height: 8),
          Text(order.notes!, style: bodyStyle),
        ],
        const SizedBox(height: 12),
        //* Actions
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 4,
          children: [
            TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Editar'),
            ),
            TextButton.icon(
              onPressed: onDelete,
              style: TextButton.styleFrom(foregroundColor: AppColors.warning),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Eliminar'),
            ),
          ],
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.onSurfaceVariant;
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(child: Text(text, style: TextStyle(color: color, fontSize: 14))),
      ],
    );
  }
}
