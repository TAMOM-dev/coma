import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/data/models/product.dart';
import 'package:flutter/material.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  //* Opens the dialog over a dimmed background. Returns the new product, or null if closed.
  static Future<Product?> show(BuildContext context) {
    return showGeneralDialog<Product>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      barrierColor: Colors.black.withValues(alpha: 0.75),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, _, _) => const AddProductDialog(),
      transitionBuilder: (_, animation, _, child) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  ProductStatus _status = ProductStatus.available;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  //* Save Product
  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Product(
        name: _nameController.text.trim(),
        status: _status,
        price: double.parse(_priceController.text.replaceAll(',', '.')),
      ),
    );
  }

  //* Dialog UI
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: AppColors.appBarBackground,
                borderRadius: BorderRadius.circular(20),
                //* Form
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel('Nombre del producto'),
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: AppColors.onSurface),
                          decoration: _inputDecoration('nombre'),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty) ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _FieldLabel('Precio'),
                                  TextFormField(
                                    controller: _priceController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(decimal: true),
                                    style: const TextStyle(color: AppColors.onSurface),
                                    decoration: _inputDecoration('\$0.00'),
                                    validator: (value) => double.tryParse(
                                              (value ?? '').replaceAll(',', '.'),
                                            ) ==
                                            null
                                        ? 'Inválido'
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _FieldLabel('Estado'),
                                  _StatusDropdown(
                                    value: _status,
                                    onChanged: (status) => setState(() => _status = status),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        Center(
                          child: SizedBox(
                            width: 180,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: _save,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.onPrimaryContainer,
                                shape: const StadiumBorder(),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: const Text('Guardar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              //* Close button
              Material(
                color: AppColors.appBarBackground,
                shape: const CircleBorder(
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                ),
                child: IconButton(
                  iconSize: 28,
                  padding: const EdgeInsets.all(12),
                  color: AppColors.primary,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.onSurface, fontSize: 15),
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  final ProductStatus value;
  final ValueChanged<ProductStatus> onChanged;

  const _StatusDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: value.color, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProductStatus>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.appBarBackground,
          borderRadius: BorderRadius.circular(12),
          icon: Icon(Icons.keyboard_arrow_down, color: value.color),
          items: ProductStatus.values
              .map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(
                    status.label,
                    style: TextStyle(
                      color: status.color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (status) {
            if (status != null) onChanged(status);
          },
        ),
      ),
    );
  }
}
