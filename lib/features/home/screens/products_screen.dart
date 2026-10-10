import 'package:coma/data/models/product.dart';
import 'package:coma/features/home/widgets/add_product_button.dart';
import 'package:coma/features/home/widgets/add_product_dialog.dart';
import 'package:coma/features/home/widgets/module_header.dart';
import 'package:coma/features/home/widgets/product_list_card.dart';
import 'package:coma/features/home/widgets/stat_panel.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //TODO: Replace with products from data source
  static const _products = [
    Product(name: 'Producto 1', status: ProductStatus.available, price: 10.0),
    Product(name: 'Producto 2', status: ProductStatus.outOfStock, price: 20.0),
    Product(name: 'Producto 3', status: ProductStatus.ordered, price: 30.0),
    Product(name: 'Producto 4', status: ProductStatus.available, price: 40.0),
    Product(name: 'Producto 5', status: ProductStatus.outOfStock, price: 50.0),
    Product(name: 'Producto 6', status: ProductStatus.ordered, price: 60.0),
    Product(name: 'Producto 7', status: ProductStatus.available, price: 70.0),
  ];

  bool _showProducts = false;
  bool _showOutOfStock = false;
  bool _showOrdered = false;

  List<Product> _byStatus(ProductStatus status) =>
      _products.where((product) => product.status == status).toList();

  @override
  Widget build(BuildContext context) {
    final outOfStock = _byStatus(ProductStatus.outOfStock);
    final ordered = _byStatus(ProductStatus.ordered);

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
          //*Add Product Button
          AddProductButton(
            onPressed: () async {
              final product = await AddProductDialog.show(context);
              //TODO: Persist the new product
              if (product == null) return;
            },
          ),
          //*Panels
          SizedBox(height: 16),
          //TODO: Add count stream to StatPanel
          StatPanel(
            label: 'Total Products',
            value: '${_products.length}',
            highlighted: true,
            expanded: _showProducts,
            onTap: () => setState(() => _showProducts = !_showProducts),
          ),
          _ExpandableProductList(visible: _showProducts, products: _products),
          const SizedBox(height: 12),
          StatPanel(
            label: 'Out of Stock',
            value: '${outOfStock.length}',
            valueColor: Theme.of(context).colorScheme.primary, // número naranja
            expanded: _showOutOfStock,
            onTap: () => setState(() => _showOutOfStock = !_showOutOfStock),
          ),
          _ExpandableProductList(visible: _showOutOfStock, products: outOfStock),
          const SizedBox(height: 12),
          StatPanel(
            label: 'Pending Orders',
            value: '${ordered.length}',
            trailingIcon: Icons.local_shipping, // el camión
            expanded: _showOrdered,
            onTap: () => setState(() => _showOrdered = !_showOrdered),
          ),
          _ExpandableProductList(visible: _showOrdered, products: ordered),
        ],
      ),
    );
  }
}

//* Product list shown below a StatPanel, animated open/closed
class _ExpandableProductList extends StatelessWidget {
  final bool visible;
  final List<Product> products;

  const _ExpandableProductList({required this.visible, required this.products});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: visible
          ? Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ProductListCard(products: products),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
