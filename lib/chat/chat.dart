import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [
    "Parcel received, on the way to deliver",
    "Okay, same location"
  ];

  // send a message
  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFF45B28F),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                ),
                SizedBox(width: 10),
                Text(
                  "Sydney O.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isUser = index % 2 != 0;
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isUser ? Color(0xFF45B28F) : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Input field
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Write here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: Color(0xFF45B28F)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
