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

  Future<void> removeItem(String productId) async {
    try {
      final response = await CartService.removeFromCart(productId);
      setState(() {
        cartItems = response['items'] ?? [];
        subtotal = double.tryParse(response['subtotal'].toString()) ?? 0.0;
      });
    } catch (e) {
      print('Lỗi khi xóa sản phẩm: $e');
    }
  }

  void updateQuantity(int index, int newQuantity) async {
    if (newQuantity < 1) return;
    
    setState(() {
      cartItems[index]['quantity'] = newQuantity;
      subtotal = cartItems.fold(0.0, (sum, item) {
        final price = double.tryParse(item['price'].toString()) ?? 0.0;
        return sum + (price * item['quantity']);
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
                                onPressed: () => removeItem(item['_id']),
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