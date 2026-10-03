import 'package:coma/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductRow extends StatelessWidget {
  final Product product;
  const ProductRow({super.key, required this.product});

  //* Products Row widget
  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          //* Product Name
          Expanded(flex: 2, child: Text(product.name, style: theme.textTheme.bodyMedium)),
          //* Product Status
          Expanded(child: Center(
            child: Text(
              product.status.label,
              style: TextStyle(color: product.status.color, fontWeight: FontWeight.bold, fontSize: 12),
            ),        
          )
          ),
          //* Product Price
          Expanded(child: Text('\$${product.price.toStringAsFixed(0)}',textAlign: TextAlign.right, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}