import 'package:flutter/material.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Giỏ hàng")),
      body: Center(child: Text("Giỏ hàng của bạn")),
    );
  }
}