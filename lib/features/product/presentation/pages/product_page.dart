import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/features/product/domain/entities/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(color: Color(0xFF4780FF)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 20, bottom: 10),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.calendar_today, color: Colors.white, size: 18),
                      SizedBox(width: 5),
                      Text(
                        DateFormat(
                          "MMMM d y",
                          "es_ES",
                        ).format(product.createdAt).toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Barcode: ${product.barcode}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelOption('Identificación', product.id),
                Divider(color: Colors.grey.shade400, height: 1, thickness: 0.5),
                labelOption('Precio', product.price),
                Divider(color: Colors.grey.shade400, height: 1, thickness: 0.5),
                labelOption('Cantidad', product.quantity.toString()),
                Divider(color: Colors.grey.shade400, height: 1, thickness: 0.5),
                labelOption('Código de barras', product.barcode.toString()),
                Divider(color: Colors.grey.shade400, height: 1, thickness: 0.5),
                labelOption('Inventario', product.inventoryId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget labelOption(String label, String value) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 44,
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
