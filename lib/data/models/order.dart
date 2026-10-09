class Order {
  final String id;
  final String supplier;
  final List<String> products;
  final double total;
  final DateTime deliveryDate;
  final String? notes;

  const Order({
    required this.id,
    required this.supplier,
    required this.products,
    required this.total,
    required this.deliveryDate,
    this.notes,
  });
}
