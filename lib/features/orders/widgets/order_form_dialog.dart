import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/core/utils/formatters.dart';
import 'package:coma/core/widgets/form_styles.dart';
import 'package:coma/data/models/order.dart';
import 'package:flutter/material.dart';

class OrderFormDialog extends StatefulWidget {
  final Order? order; //* null = create, otherwise edit
  const OrderFormDialog({super.key, this.order});

  //* Opens the form over a dimmed background. Returns the saved order, or null if cancelled.
  static Future<Order?> show(BuildContext context, {Order? order}) {
    return showDialog<Order>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => OrderFormDialog(order: order),
    );
  }

  @override
  State<OrderFormDialog> createState() => _OrderFormDialogState();
}

class _OrderFormDialogState extends State<OrderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productsFieldKey = GlobalKey<FormFieldState<List<String>>>();
  late final _supplierController = TextEditingController(text: widget.order?.supplier);
  late final _totalController = TextEditingController(text: widget.order?.total.toStringAsFixed(2));
  late final _notesController = TextEditingController(text: widget.order?.notes);
  final _productController = TextEditingController();
  final _dateController = TextEditingController();
  late final List<String> _products = [...?widget.order?.products];
  DateTime? _deliveryDate;

  bool get _isEditing => widget.order != null;

  @override
  void initState() {
    super.initState();
    _deliveryDate = widget.order?.deliveryDate;
    if (_deliveryDate != null) _dateController.text = Formatters.date(_deliveryDate!);
  }

  @override
  void dispose() {
    _supplierController.dispose();
    _totalController.dispose();
    _notesController.dispose();
    _productController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  //* Products list
  void _addProduct() {
    final name = _productController.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _products.add(name);
      _productController.clear();
    });
    _syncProductsField();
  }

  void _removeProduct(int index) {
    setState(() => _products.removeAt(index));
    _syncProductsField();
  }

  //* Re-validate only if an error is already shown, so it clears without appearing early
  void _syncProductsField() {
    final field = _productsFieldKey.currentState;
    field?.didChange(_products);
    if (field?.hasError ?? false) field!.validate();
  }

  //* Delivery date
  Future<void> _pickDate() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final initial = _deliveryDate ?? today;
    final first = DateTime(today.year - 1);
    final last = DateTime(today.year + 5);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: initial.isBefore(first) ? initial : first, //* widen range so an older/later saved date fits
      lastDate: initial.isAfter(last) ? initial : last,
    );
    if (picked == null) return;
    setState(() {
      _deliveryDate = picked;
      _dateController.text = Formatters.date(picked);
    });
  }

  //* Save Order
  void _save() {
    _addProduct(); //* keep a product typed but not yet added
    if (!_formKey.currentState!.validate()) return;
    final notes = _notesController.text.trim();
    Navigator.of(context).pop(
      Order(
        id: widget.order?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        supplier: _supplierController.text.trim(),
        products: List.unmodifiable(_products),
        total: _parsePrice(_totalController.text)!,
        deliveryDate: _deliveryDate!,
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  static double? _parsePrice(String text) {
    final trimmed = text.trim();
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(trimmed)) return null;
    final value = double.tryParse(trimmed.replaceAll(',', '.'));
    return (value == null || !value.isFinite) ? null : value;
  }

  //* Dialog UI
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.appBarBackground,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEditing ? 'Editar pedido' : 'Nuevo pedido',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 24),

              //* Supplier
              const FieldLabel('Empresa o distribuidor'),
              TextFormField(
                controller: _supplierController,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: AppColors.onSurface),
                decoration: formInputDecoration('nombre'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 20),

              //* Products
              const FieldLabel('Productos pedidos'),
              FormField<List<String>>(
                key: _productsFieldKey,
                initialValue: _products,
                validator: (_) => _products.isEmpty ? 'Agrega al menos un producto' : null,
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _productController,
                      style: const TextStyle(color: AppColors.onSurface),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addProduct(),
                      decoration: formInputDecoration(
                        'producto',
                        suffixIcon: IconButton(
                          tooltip: 'Agregar producto',
                          icon: const Icon(Icons.add_circle, color: AppColors.primary),
                          onPressed: _addProduct,
                        ),
                      ).copyWith(errorText: field.errorText),
                    ),
                    if (_products.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final (index, product) in _products.indexed)
                            InputChip(
                              label: Text(product),
                              labelStyle: const TextStyle(color: AppColors.onSurface),
                              backgroundColor: AppColors.background,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                              deleteIconColor: AppColors.onSurfaceVariant,
                              onDeleted: () => _removeProduct(index),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //* Total + delivery date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldLabel('Precio total'),
                        TextFormField(
                          controller: _totalController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle(color: AppColors.onSurface),
                          decoration: formInputDecoration('\$0.00'),
                          validator: (value) => _parsePrice(value ?? '') == null ? 'Precio inválido' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldLabel('Entrega'),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: _pickDate,
                          style: const TextStyle(color: AppColors.onSurface),
                          decoration: formInputDecoration(
                            'fecha',
                            suffixIcon: const Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
                          ),
                          validator: (_) => _deliveryDate == null ? 'Elige una fecha' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //* Notes
              const FieldLabel('Notas (opcional)'),
              TextFormField(
                controller: _notesController,
                minLines: 3,
                maxLines: 5,
                style: const TextStyle(color: AppColors.onSurface),
                decoration: formInputDecoration('observaciones o instrucciones'),
              ),
              const SizedBox(height: 32),

              //* Actions
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimaryContainer,
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        child: const Text('Guardar'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
