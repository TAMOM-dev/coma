import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget{
  final VoidCallback onPressed;
  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Nuevo producto'),
    );
  }
}