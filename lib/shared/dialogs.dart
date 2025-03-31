import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/shared/util/thousand_input_formatter.dart';
import 'package:stock_app/shared/widgets/custom_input.dart';

Future<String> showInputDialog(
  BuildContext context, {
  String? title,
  String? hintText,
  String defaultValue = '',
  String? actionText,
}) async {
  String value = '';
  await showAdaptiveDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          title ?? 'No defined',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: CustomInput(
          controller: TextEditingController(text: defaultValue),
          hintText: hintText,
          onChanged: (text) {
            value = text;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              value = '';
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Handle create inventory action
              Navigator.of(context).pop();
            },
            child: Text(actionText ?? 'Crear'),
          ),
        ],
      );
    },
  );

  return value;
}

Future<List<String>> showFormDialog(
  BuildContext context, {
  String? title,
  String? hintTextField1,
  String? hintTextField2,
  String? hintTextField3,
  String? defaultValue1,
  String? defaultValue2,
  String? defaultValue3,
  String? actionText,
}) async {
  String value1 = defaultValue1 ?? '';
  String value2 = defaultValue2 ?? '';
  String value3 = defaultValue3 ?? '';

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  await showAdaptiveDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          title ?? 'No defined',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
              controller: TextEditingController(text: defaultValue1),
              focusNode: focus1,
              hintText: hintTextField1,
              onChanged: (text) {
                value1 = text;
              },
              onSubmitted: (text) {
                if (text.isEmpty) {
                  focus1.requestFocus();
                  return;
                }
                focus2.requestFocus();
              },
            ),
            SizedBox(height: 5),
            CustomInput(
              controller: TextEditingController(text: defaultValue2),
              focusNode: focus2,
              hintText: hintTextField2,
              onChanged: (text) {
                value2 = text;
              },
              onSubmitted: (text) {
                if (text.isEmpty) {
                  focus2.requestFocus();
                  return;
                }
                focus3.requestFocus();
              },
              inputFormatters: [ThousandInputFormatter()],
            ),
            SizedBox(height: 5),
            CustomInput(
              controller: TextEditingController(text: defaultValue3),
              focusNode: focus3,
              hintText: hintTextField3,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
              ],
              onChanged: (text) {
                value3 = text;
              },
              onSubmitted: (text) {
                if (text.isEmpty) {
                  focus1.requestFocus();
                  return;
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              value1 = '';
              value2 = '';
              value3 = '';
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Handle create inventory action
              Navigator.of(context).pop();
            },
            child: Text(actionText ?? 'Crear'),
          ),
        ],
      );
    },
  );

  return [value1, value2, value3];
}
