import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('es');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty) {
      return TextEditingValue(text: '');
    }
    // Eliminar caracteres no numéricos
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Formatear con separadores de miles
    String formattedText = _formatter.format(int.parse(newText));

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
