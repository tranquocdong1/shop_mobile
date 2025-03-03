// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile_app_shop/screens/about_screen.dart';
import 'package:mobile_app_shop/screens/blog_screen.dart';
import 'package:mobile_app_shop/screens/cart_screen.dart';
import 'package:mobile_app_shop/screens/checkout_screen.dart';
import 'package:mobile_app_shop/screens/contact_screen.dart';
import 'package:mobile_app_shop/screens/flowers_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình
  final List<Widget> _screens = [
    HomeContent(),
    AboutScreen(),
    FlowersScreen(),
    CartScreen(),
    CheckoutScreen(),
    BlogScreen(),
    ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Về chúng tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Hoa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Thanh toán',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Liên hệ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[400], // Màu phù hợp với chủ đề hoa
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Để hiển thị tất cả items
      ),
    );
  }
}

// Tách nội dung Home thành widget riêng
class HomeContent extends StatelessWidget {
  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flower Shop",
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.pink[50],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.pink[400]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner chính
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.pink[100],
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "../assets/bg_2.jpg",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoa Tươi Mỗi Ngày",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Mang sắc màu đến cuộc sống của bạn",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Section danh mục nổi bật
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Danh Mục Nổi Bật",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _categoryCard("Hoa Cưới", Icons.favorite, Colors.pink[200]!),
                  SizedBox(width: 10),
                  _categoryCard("Hoa Sinh Nhật", Icons.cake, Colors.purple[200]!),
                  SizedBox(width: 10),
                  _categoryCard("Hoa Tặng Mẹ", Icons.local_florist, Colors.red[200]!),
                ],
              ),
            ),

            // Section sản phẩm nổi bật
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Sản Phẩm Nổi Bật",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _productCard(
                    context,
                    "Bó Hoa Hồng Đỏ",
                    "250.000 VNĐ",
                    _rosePlaceholder(), // Placeholder riêng cho hoa hồng
                    isFeatured: true,
                  ),
                  SizedBox(height: 10),
                  _productCard(
                    context,
                    "Giỏ Hoa Cẩm Chướng",
                    "300.000 VNĐ",
                    _carnationPlaceholder(), // Placeholder riêng cho cẩm chướng
                    isFeatured: false,
                  ),
                ],
              ),
            ),

            // Nút đăng xuất
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Đăng xuất",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget cho category card
  Widget _categoryCard(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder cho hoa hồng
  Widget _rosePlaceholder() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.local_florist, size: 40, color: Colors.red[400]),
          Image.asset(
                      "../assets/kind-1.png",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
        ],
      ),
    );
  }

  // Placeholder cho hoa cẩm chướng
  Widget _carnationPlaceholder() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.local_florist, size: 60, color: Colors.pink[300]),
          Image.asset(
                      "../assets/kind-2.png",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
        ],
      ),
    );
  }

  // Widget cho product card
  Widget _productCard(BuildContext context, String name, String price, Widget placeholder, {required bool isFeatured}) {
    return Container(
      height: isFeatured ? 120 : 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isFeatured ? 0.3 : 0.2),
            spreadRadius: isFeatured ? 3 : 2,
            blurRadius: 5,
          ),
        ],
        border: isFeatured ? Border.all(color: Colors.pink[400]!, width: 2) : null,
      ),
      child: Row(
        children: [
          placeholder, // Sử dụng placeholder riêng cho từng sản phẩm
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: isFeatured ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: isFeatured ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isFeatured)
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.pink[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Hot",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              isFeatured ? Icons.star : Icons.add_shopping_cart,
              color: Colors.pink[400],
              size: isFeatured ? 30 : 24,
            ),
          ),
        ],
      ),
    );
  }
}
