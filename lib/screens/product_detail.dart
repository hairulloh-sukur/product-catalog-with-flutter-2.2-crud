import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Product Detail'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Text(
                product['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Image.network(product['image_url']),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.all(5),
              child: Text(
                NumberFormat.currency(
                        locale: 'id', symbol: 'Rp. ', decimalDigits: 2)
                    .format(double.parse(product['price'])),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(5),
              child: Text('Description:\n${product['description']}'),
            ),
          ),
        ],
      ),
    );
  }
}
