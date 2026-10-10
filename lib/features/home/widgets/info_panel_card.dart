import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/features/home/screens/products_screen.dart';
import 'package:coma/features/home/widgets/view_low_stock_button.dart';
import 'package:flutter/material.dart';

class InfoPanelCard extends StatelessWidget{
  const InfoPanelCard({super.key});

  @override
  Widget build(BuildContext context) {
    //* Dark navy on orange for contrast
    const foreground = AppColors.background;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFA233), AppColors.primary],
        ),
      ),
      child: Stack(
        children: [
          //* Decorative background icon
          Positioned(
            right: -24,
            bottom: -24,
            child: Icon(
              Icons.production_quantity_limits,
              size: 140,
              color: foreground.withValues(alpha: 0.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //*Card information
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: foreground.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.warning_amber_rounded, color: foreground, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'PRODUCTOS FUERA DE STOCK',
                        style: TextStyle(
                          color: foreground,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //TODO: Replace with out of stock count from data source
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '14',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 1),
                      ),
                      TextSpan(
                        text: '  productos',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  style: TextStyle(color: foreground),
                ),
                const SizedBox(height: 6),
                Text(
                  'Necesitan reposición pronto.',
                  style: TextStyle(color: foreground.withValues(alpha: 0.75), fontSize: 14),
                ),
                const SizedBox(height: 20),
                //*Out of stock Button
                ViewLowStockButton(onPressed: () => ProductsScreen.showOutOfStock(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
