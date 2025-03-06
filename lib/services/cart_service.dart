import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  static const String baseUrl = 'http://localhost:3000';
  static const int timeoutSeconds = 10;

  // Xử lý phản hồi API với kiểm tra dữ liệu tốt hơn
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        
        // Kiểm tra và đảm bảo các trường cần thiết luôn tồn tại
        if (!jsonData.containsKey('items')) {
          jsonData['items'] = [];
        }
        if (!jsonData.containsKey('subtotal')) {
          jsonData['subtotal'] = "0.00";
        }
        if (!jsonData.containsKey('count')) {
          jsonData['count'] = 0;
        }
        
        return jsonData;
      } catch (e) {
        print('Lỗi khi parse JSON: $e');
        // Trả về một object mặc định khi không thể parse JSON
        return {'items': [], 'subtotal': "0.00", 'count': 0, 'error': 'Lỗi parse dữ liệu'};
      }
    } else {
      print('Lỗi API: ${response.statusCode} - ${response.body}');
      throw Exception('Lỗi API: ${response.statusCode}');
    }
  }

  // Lấy giỏ hàng với xử lý lỗi tốt hơn
  static Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/cart'))
          .timeout(Duration(seconds: timeoutSeconds));

      print('Phản hồi từ server: ${response.statusCode}');
      
      // Kiểm tra cả trường hợp response body rỗng
      if (response.body.isEmpty) {
        print('Phản hồi rỗng từ server');
        return {'items': [], 'subtotal': "0.00", 'count': 0};
      }
      
      print('Nội dung phản hồi: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print('Lỗi khi tải giỏ hàng: $e');
      // Trả về giỏ hàng rỗng thay vì throw exception
      return {'items': [], 'subtotal': "0.00", 'count': 0, 'error': e.toString()};
    }
  }

  // Các phương thức khác giữ nguyên...
  // Thêm sản phẩm vào giỏ hàng
  static Future<Map<String, dynamic>> addToCart(
      String productId, int quantity) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/add-to-cart'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'productId': productId, 'quantity': quantity}),
          )
          .timeout(Duration(seconds: timeoutSeconds));
      return _handleResponse(response);
    } catch (e) {
      print('Lỗi khi thêm sản phẩm vào giỏ hàng: $e');
      return {'message': 'Lỗi khi thêm sản phẩm: $e', 'success': false};
    }
  }

  // Xóa sản phẩm khỏi giỏ hàng
  static Future<Map<String, dynamic>> removeFromCart(String productId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/remove-from-cart'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'productId': productId}),
          )
          .timeout(Duration(seconds: timeoutSeconds));
      return _handleResponse(response);
    } catch (e) {
      print('Lỗi khi xóa sản phẩm khỏi giỏ hàng: $e');
      return {'message': 'Lỗi khi xóa sản phẩm: $e', 'success': false};
    }
  }
}