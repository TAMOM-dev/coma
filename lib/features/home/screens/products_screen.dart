import 'package:coma/features/home/widgets/add_product_button.dart';
import 'package:coma/features/home/widgets/add_product_dialog.dart';
import 'package:coma/features/home/widgets/module_header.dart';
import 'package:coma/features/home/widgets/stat_panel.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Header
          ModuleHeader(
            mainTitle: 'Inventario',
            accentTitle: 'Principal',
            description: 'Gestiona los activos técnicos y el catálogo de productos con seguimiento en tiempo real e integración con la cadena de suministro.',
          ),
          SizedBox(height: 32),
          //*Body
          AddProductButton(
            onPressed: () async {
              final product = await AddProductDialog.show(context);
              //TODO: Persist the new product
              if (product == null) return;
            },
          ),
          SizedBox(height: 16),
          //TODO: Add count stream to StatPanel
          StatPanel(
            label: 'Total Products',
            value: '100',
            highlighted: true, 
          ),
          const SizedBox(height: 12),
          StatPanel(
            label: 'Out of Stock',
            value: '24',
            valueColor: Theme.of(context).colorScheme.primary, // número naranja
          ),
          const SizedBox(height: 12),
          StatPanel(
            label: 'Pending Orders',
            value: '16',
            trailingIcon: Icons.local_shipping, // el camión
          ),
        ],
      ),
    );
  }
}
