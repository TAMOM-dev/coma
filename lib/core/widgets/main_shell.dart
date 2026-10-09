import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  final List<Widget> pages;
  final List<String> titles;
  const MainShell({super.key, required this.pages, required this.titles});


  @override
  State<StatefulWidget> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      //*AppBar
      appBar: AppBar(
        title: Text(widget.titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {
              //TODO: Implement notification functionality
            },
          ),
        ],
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