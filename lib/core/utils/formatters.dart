class Formatters {
  Formatters._(); //* Private constructor to prevent instantiation

  static const _months = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];

  //* $1234.5 -> "$1234.50"
  static String price(double value) => '\$${value.toStringAsFixed(2)}';

  //* 2026-10-08 -> "8 oct 2026"
  static String date(DateTime date) => '${date.day} ${_months[date.month - 1]} ${date.year}';
}
