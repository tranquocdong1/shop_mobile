import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login"); // Quay về trang Login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Chào mừng bạn!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text("Đăng xuất"),
            ),
          ],
        ),
      ),
    );
  }
}
