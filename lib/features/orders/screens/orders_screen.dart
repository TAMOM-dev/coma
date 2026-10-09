import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/data/models/order.dart';
import 'package:coma/features/home/widgets/add_product_button.dart';
import 'package:coma/features/home/widgets/module_header.dart';
import 'package:coma/features/orders/widgets/order_card.dart';
import 'package:coma/features/orders/widgets/order_form_dialog.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //TODO: Replace with orders from data source
  final List<Order> _orders = [];
  String? _expandedId;

  //* Soonest delivery first
  void _sortOrders() => _orders.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));

  Future<void> _addOrder() async {
    final order = await OrderFormDialog.show(context);
    if (order == null) return;
    setState(() {
      _orders.add(order);
      _sortOrders();
    });
  }

  Future<void> _editOrder(Order current) async {
    final updated = await OrderFormDialog.show(context, order: current);
    if (updated == null) return;
    setState(() {
      final index = _orders.indexWhere((order) => order.id == current.id);
      if (index != -1) _orders[index] = updated;
      _sortOrders();
    });
  }

  Future<void> _deleteOrder(Order order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.appBarBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Eliminar pedido', style: TextStyle(color: AppColors.onSurface)),
        content: Text(
          '¿Eliminar el pedido de ${order.supplier}? Esta acción no se puede deshacer.',
          style: TextStyle(color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.warning),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() {
      _orders.removeWhere((o) => o.id == order.id);
      if (_expandedId == order.id) _expandedId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Header
          const ModuleHeader(
            mainTitle: 'Pedidos',
            accentTitle: 'Proveedores',
            description: 'Recuerda qué pediste a cada proveedor o distribuidor, cuánto cuesta y cuándo llega.',
          ),
          const SizedBox(height: 32),
          //*Add Order Button, hidden while the empty state shows its own
          if (_orders.isNotEmpty) ...[
            AddProductButton(label: 'Nuevo pedido', onPressed: _addOrder),
            const SizedBox(height: 16),
          ],
          //*Orders
          if (_orders.isEmpty)
            _EmptyOrders(onAdd: _addOrder)
          else
            for (final order in _orders) ...[
              OrderCard(
                key: ValueKey(order.id),
                order: order,
                expanded: _expandedId == order.id,
                onTap: () => setState(() => _expandedId = _expandedId == order.id ? null : order.id),
                onEdit: () => _editOrder(order),
                onDelete: () => _deleteOrder(order),
              ),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyOrders({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            const Icon(Icons.local_shipping_outlined, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text(
              'Aún no tienes pedidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Registra tu primer pedido para saber qué esperas recibir.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onAdd,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: const StadiumBorder(),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Agregar primer pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
