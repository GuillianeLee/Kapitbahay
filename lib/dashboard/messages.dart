import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool isChatSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isChatSelected = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isChatSelected ? Color.fromRGBO(69, 178, 143, 1) : Color(0xFFE5F6EE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Chat",
                  style: TextStyle(
                    color: isChatSelected ? Colors.white : Color.fromRGBO(69, 178, 143, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  isChatSelected = false;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isChatSelected ? Color(0xFFE5F6EE) : Color.fromRGBO(69, 178, 143, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    color: isChatSelected ?Color.fromRGBO(69, 178, 143, 1) : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Expanded(
          child: isChatSelected ? _buildChatScreen() : _buildNotificationsScreen(),
        ),
      ],
    );
  }

  Widget _buildChatScreen() {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundColor: Colors.grey.shade300),
          title: Text('Shyrine Jardin', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('This chat remains open for this ...'),
          trailing: Text('Sun', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildNotificationsScreen() {
    // Notifications page
    return Center(
      child: Text(
        'No notifications available!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
