import 'package:coma/core/theme/app_colors.dart';
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          //* Card Header
          Container(
            width: double.infinity,
            color: AppColors.appBarBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
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

          //* Product Items
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final product in _currentItems) ...[
                ProductRow(product: product),
              ],
            ],
          ),

          //* Pagination Controls
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //* Pagination
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
