import 'package:flutter/material.dart';
class FlowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tất cả hoa")),
      body: Center(child: Text("Danh sách các loại hoa")),
    );
  }
}