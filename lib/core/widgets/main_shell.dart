import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  final List<Widget> pages;
  final List<String> titles;
  const MainShell({super.key, required this.pages, required this.titles});

  //* Switches the shell to the tab showing a screen of type T, e.g. selectPage<ProductsScreen>(context)
  static void selectPage<T extends Widget>(BuildContext context) {
    context.findAncestorStateOfType<_MainShellState>()?._selectPage<T>();
  }


  @override
  State<StatefulWidget> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _selectPage<T extends Widget>() {
    final index = widget.pages.indexWhere((page) => page is T);
    if (index != -1) setState(() => _selectedIndex = index);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      //*AppBar
      appBar: AppBar(
        title: Row(
          children: [
            //* Brand logo
            Image.asset('assets/images/logo/coma_logo.png', height: 26),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              tooltip: 'Notificaciones',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.appBarBackground,
                foregroundColor: AppColors.onSurface,
              ),
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {
                //TODO: Implement notification functionality
              },
            ),
          ),
        ],
        //* Subtle separator from the content
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.onSurface.withValues(alpha: 0.08)),
        ),
      ),
      //*Body
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.pages,
      ),
      //*BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'Productos'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Pedidos'),
        ],
      ),
    );
  }
}