import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toko_online/screens/add_product.dart';
import 'package:toko_online/screens/edit_product.dart';
import 'package:toko_online/screens/product_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://10.0.2.2/api/products/';

  Future getProducts() async {
    var respone = await http.get(Uri.parse(url));
    return json.decode(respone.body);
  }

  Future deleteProduct(String id) async {
    var respone = await http.delete(Uri.parse(url + id));
    return json.decode(respone.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          }),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('List of Products'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: (snapshot.data as dynamic)['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              // *Photo of Product
                              margin: EdgeInsets.all(5),
                              child: Image.network((snapshot.data
                                  as dynamic)['data'][index]['image_url']),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    // *Name of Product
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      (snapshot.data as dynamic)['data'][index]
                                          ['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    // *Description of Product
                                    alignment: Alignment.topLeft,
                                    color: Colors.lightBlue[50],
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                        (snapshot.data as dynamic)['data']
                                            [index]['description']),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          // *Price of Product
                                          margin: EdgeInsets.all(5),
                                          child: Text(NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: 'Rp. ',
                                                  decimalDigits: 2)
                                              .format(double.parse((snapshot
                                                      .data as dynamic)['data']
                                                  [index]['price']))),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          // *Detail Icon
                                          child: IconButton(
                                            icon: Icon(Icons.view_headline),
                                            iconSize: 16,
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail((snapshot
                                                                      .data
                                                                  as dynamic)[
                                                              'data'][index])));
                                            },
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          // *Edit Icon
                                          child: IconButton(
                                            icon: Icon(Icons.edit),
                                            iconSize: 16,
                                            color: Colors.orangeAccent,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProduct((snapshot
                                                                      .data
                                                                  as dynamic)[
                                                              'data'][index])));
                                            },
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          // *Delete Icon
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            iconSize: 16,
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              deleteProduct((snapshot.data
                                                              as dynamic)[
                                                          'data'][index]['id']
                                                      .toString())
                                                  .then((value) {
                                                setState(() {});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Deleted Success')));
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text('Data Loading...');
          }
        },
      ),
    );
  }
}
