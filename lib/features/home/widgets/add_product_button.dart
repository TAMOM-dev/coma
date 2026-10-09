import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String label;
  const AddProductButton({super.key, required this.onPressed, this.label = 'Nuevo producto'});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(label),
    );
  }
}