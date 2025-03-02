import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import '../models/contact_model.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();

  Future<void> _sendMessage() async {
    final contact = ContactMessage(
      name: _nameController.text,
      email: _emailController.text,
      subject: _subjectController.text,
      message: _messageController.text,
    );

    bool success = await ContactService.submitContact(contact);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gửi thành công!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gửi thất bại, vui lòng thử lại.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liên hệ")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Họ và tên"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
  controller: _subjectController,
  decoration: InputDecoration(labelText: "Chủ đề"),
),

            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: "Tin nhắn"),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text("Gửi tin nhắn"),
            ),
          ],
        ),
      ),
    );
  }
}
