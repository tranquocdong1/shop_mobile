import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    final response = await _authService.loginUser(
      _emailController.text,
      _passwordController.text,
    );

    if (response["success"]) {
      Navigator.pushReplacementNamed(context, "/home"); // Chuyển đến Home nếu đăng nhập thành công
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đăng nhập thất bại! Sai email hoặc mật khẩu."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, "/register"); // Chuyển sang trang Đăng ký
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Mật khẩu"), obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _login, child: Text("Đăng nhập")),
            TextButton(onPressed: _goToRegister, child: Text("Chưa có tài khoản? Đăng ký ngay")),
          ],
        ),
      ),
    );
  }
}
