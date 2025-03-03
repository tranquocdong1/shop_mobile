import 'package:flutter/material.dart';
class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blog")),
      body: Center(child: Text("Tin tức về hoa")),
    );
  }
}