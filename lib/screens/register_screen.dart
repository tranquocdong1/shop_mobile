import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final AuthService _authService = AuthService();

  void _register() async {
    final response = await _authService.registerUser(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      _confirmPasswordController.text,
      int.tryParse(_ageController.text) ?? 0,
    );

    if (response["success"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đăng ký thành công! Hãy đăng nhập."),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, "/login"); // Chuyển sang trang đăng nhập
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng ký")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Tên")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Mật khẩu"), obscureText: true),
            TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: "Xác nhận mật khẩu"), obscureText: true),
            TextField(controller: _ageController, decoration: InputDecoration(labelText: "Tuổi"), keyboardType: TextInputType.number),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _register, child: Text("Đăng ký")),
          ],
        ),
      ),
    );
  }
}
