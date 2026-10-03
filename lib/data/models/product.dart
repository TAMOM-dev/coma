import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ProductStatus {
  available,
  outOfStock,
  ordered,
}

extension ProductStatusX on ProductStatus {
  String get label {
    switch (this) {
      case ProductStatus.available:
        return 'DISPONIBLE';
      case ProductStatus.outOfStock:
        return 'AGOTADO';
      case ProductStatus.ordered:
        return 'PEDIDO';
    }
  }

  Color get color {
    switch (this) {
      case ProductStatus.available:
        return AppColors.primary; 
      case ProductStatus.outOfStock:
        return AppColors.warning; 
      case ProductStatus.ordered:
        return AppColors.orderedLabelColor; 
    }
  }
}

class Product {
  final String name;
  final ProductStatus status;
  final double price;

  const Product({required this.name, required this.status, required this.price});
}

