import 'package:coma/data/models/product.dart';
import 'package:coma/features/home/widgets/info_panel_card.dart';
import 'package:coma/features/home/widgets/module_header.dart';
import 'package:coma/features/home/widgets/product_list_card.dart';
import 'package:coma/features/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //*ScrollView
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          //*Header
          ModuleHeader(mainTitle: 'Seguimiento', accentTitle: 'Producto', description: 'Controla. Hazlo crecer.'),
          SizedBox(height: 32),
          //*Body
          SearchBarWidget(),
          SizedBox(height: 32),
          InfoPanelCard(),
          SizedBox(height: 32),
          ProductListCard(
            products: const [
              Product(name: 'Producto 1', status: ProductStatus.available, price: 10.0),
              Product(name: 'Producto 2', status: ProductStatus.outOfStock, price: 20.0),
              Product(name: 'Producto 3', status: ProductStatus.ordered, price: 30.0),
              Product(name: 'Producto 4', status: ProductStatus.available, price: 40.0),
              Product(name: 'Producto 5', status: ProductStatus.outOfStock, price: 50.0),
              Product(name: 'Producto 6', status: ProductStatus.ordered, price: 60.0),
              Product(name: 'Producto 7', status: ProductStatus.available, price: 70.0),
            ],
          )
        ],
      ),
    );
  }
}