import 'package:flutter/material.dart';
import 'package:mobile_app_shop/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> cartItems = [];
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    try {
      final response = await CartService.getCart();
      setState(() {
        cartItems = response['items'] ?? [];
        subtotal = double.tryParse(response['subtotal'].toString()) ?? 0.0;
      });
    } catch (e) {
      print('Lỗi khi tải giỏ hàng: $e');
    }
  }

  Future<void> removeItem(String? productId) async {
    if (productId == null || productId.isEmpty) {
      print('Không thể xóa sản phẩm: ID null hoặc rỗng');
      return;
    }

    try {
      print('Đang xóa sản phẩm có ID: $productId');
      final response = await CartService.removeFromCart(productId);

      if (response['success'] == false) {
        print('Lỗi khi xóa: ${response['message']}');
        // Có thể hiển thị thông báo lỗi cho người dùng ở đây
        return;
      }

      setState(() {
        cartItems = response['items'] ?? [];
        subtotal = double.tryParse(response['subtotal'].toString()) ?? 0.0;
      });

      print(
          'Đã xóa sản phẩm thành công, số lượng sản phẩm còn lại: ${cartItems.length}');
    } catch (e) {
      print('Exception khi xóa sản phẩm: $e');
      // Hiển thị thông báo lỗi cho người dùng
    }
  }

  void updateQuantity(int index, int newQuantity) async {
    if (newQuantity < 1 || index >= cartItems.length || index < 0) return;

    setState(() {
      cartItems[index]['quantity'] = newQuantity;
      subtotal = cartItems.fold(0.0, (sum, item) {
        final price =
            double.tryParse(item['price']?.toString() ?? '0.0') ?? 0.0;
        return sum + (price * (item['quantity'] ?? 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Giỏ hàng của tôi")),
      body: cartItems.isEmpty
          ? Center(child: Text("Giỏ hàng trống"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.network(
                            item['image'] ?? 'https://via.placeholder.com/150',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['name'] ?? 'Sản phẩm'),
                          subtitle:
                              Text("\$${item['price'].toStringAsFixed(2)}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () =>
                                    updateQuantity(index, item['quantity'] - 1),
                              ),
                              Text("${item['quantity']}"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    updateQuantity(index, item['quantity'] + 1),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Fix: Changed from '_id' to 'productId' to match the API response
                                  String? id = item['productId']?.toString();
                                  print('ID sản phẩm cần xóa: $id');
                                  if (id != null) {
                                    removeItem(id);
                                  } else {
                                    // Fallback to '_id' if 'productId' is not available
                                    id = item['_id']?.toString();
                                    print('Thử lại với _id: $id');
                                    if (id != null) {
                                      removeItem(id);
                                    } else {
                                      print('Không thể xóa: ID sản phẩm là null');
                                      // Hiển thị thông báo lỗi cho người dùng
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Không thể xóa sản phẩm: ID không hợp lệ')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Tổng tiền: \$${subtotal.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                        child: Text("Tiến hành thanh toán"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}