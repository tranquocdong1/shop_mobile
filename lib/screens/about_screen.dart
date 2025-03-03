import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Về chúng tôi")),
      body: Center(child: Text("Thông tin về cửa hàng hoa")),
    );
  }
}