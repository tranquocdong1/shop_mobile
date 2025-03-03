import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"));

  Future<Map<String, dynamic>> registerUser(
      String name, String email, String password, String confirmPassword, int age) async {
    try {
      final response = await _dio.post(
        "/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirmpassword": confirmPassword,
          "age": age,
        },
      );

      return response.data; // API trả về JSON
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return {"success": false, "message": "Lỗi kết nối đến server."};
    }
  }
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
  try {
    final response = await _dio.post(
      "/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    return response.data;
  } catch (e) {
    print("Lỗi đăng nhập: $e");
    return {"success": false, "message": "Lỗi đăng nhập."};
  }
}

}
