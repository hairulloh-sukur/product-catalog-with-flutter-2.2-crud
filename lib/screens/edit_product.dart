import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/home_page.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  // const EditProduct({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final String url = 'http://10.0.2.2/api/products/';

  final Map product;

  EditProduct(this.product);

  Future updateProduct() async {
    var respone = await http.put(
      Uri.parse(url + product['id'].toString()),
      body: {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
        'image_url': _imageUrlController.text
      },
    );

    return json.decode(respone.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Edit Product'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name:'),
                    controller: _nameController..text = product['name'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert Product Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description:'),
                    controller: _descriptionController
                      ..text = product['description'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert Product Description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price:'),
                    controller: _priceController..text = product['price'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert Product Price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL:'),
                    controller: _imageUrlController
                      ..text = product['image_url'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert Product Image URL';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Updated Success')));
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
