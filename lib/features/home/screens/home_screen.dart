import 'package:coma/features/home/widgets/info_panel_card.dart';
import 'package:coma/features/home/widgets/module_header.dart';
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
        ],
      ),
    );
  }
}