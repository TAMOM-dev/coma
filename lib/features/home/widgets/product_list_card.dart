import 'package:coma/data/models/product.dart';
import 'package:coma/features/home/widgets/product_row.dart';
import 'package:flutter/material.dart';

class ProductListCard extends StatefulWidget {
  final List<Product> products;
  final int itemsPerPage;

  const ProductListCard({
    super.key,
    required this.products,
    this.itemsPerPage = 5,
  });

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  int _currentPage = 0;

  //* Calculate Pages
  int get _totalPages => (widget.products.length / widget.itemsPerPage).ceil();

  //* Get Current Items for the current page
  List<Product> get _currentItems {
    final start = _currentPage * widget.itemsPerPage;
    final end = (start + widget.itemsPerPage).clamp(0, widget.products.length);
    return widget.products.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    //* Card with Product List and Pagination
    return Card(
      clipBehavior:
          Clip.antiAlias,
      child: Column(
        children: [
          //* Card Header
          Container(
            width: double.infinity,
            color: theme
                .colorScheme
                .surfaceContainerHighest, // un tono distinto al body
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('PRODUCT', style: theme.textTheme.bodyMedium),
                ),
                Expanded(
                  child: Center(
                    child: Text('STATUS', style: theme.textTheme.bodyMedium),
                  ),
                ),
                Expanded(
                  child: Text(
                    'PRICE',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          // --- Cuerpo: filas de productos ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                for (final product in _currentItems) ...[
                  ProductRow(product: product),
                  if (product != _currentItems.last)
                    Divider(
                      height: 1,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.08,
                      ),
                    ),
                ],
              ],
            ),
          ),

          // --- Paginado: siempre al final ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page ${_currentPage + 1} of $_totalPages',
                  style: theme.textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 0
                          ? () => setState(() => _currentPage--)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _currentPage < _totalPages - 1
                          ? () => setState(() => _currentPage++)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
