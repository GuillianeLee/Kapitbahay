import 'package:flutter/material.dart';
import '/location/now.dart';

class ChatOfferScreen extends StatefulWidget {
  const ChatOfferScreen({super.key});

  @override
  _ChatOfferScreenState createState() => _ChatOfferScreenState();
}

class _ChatOfferScreenState extends State<ChatOfferScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _counterOfferController = TextEditingController();
  bool _isDeclined = false; // Track if the user declined the offer
  List<String> chatMessages = []; // Stores chat messages

  // Function to submit counter offer
  void _submitCounterOffer() {
    String offer = _counterOfferController.text.trim();
    if (offer.isNotEmpty) {
      setState(() {
        chatMessages.add("You offered PHP $offer");
        _counterOfferController.clear();
        _isDeclined = false;
      });
    }
  }

  // Function to send a chat message
  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        chatMessages.add(message); // Add message to chat
        _messageController.clear(); // Clear input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF45B28F),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Replace with actual image
                ),
                const SizedBox(width: 10),

                // Name
                const Text(
                  "Guillermo Raby",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),

          // Main Offer or Counter Offer UI
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Help me find and purchase this book in any Fullybooked branches",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                GestureDetector(
                  onTap: () {
                    // Handle offer details
                  },
                  child: const Text(
                    "Offered you PHP 5,000.00",
                    style: TextStyle(fontSize: 16, color: Colors.green, decoration: TextDecoration.underline),
                  ),
                ),

                const SizedBox(height: 10),

                // If user declined, show counter-offer UI
                if (_isDeclined) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _counterOfferController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "PHP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _submitCounterOffer, // Call function to submit offer
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF45B28F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Make Offer", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ]
                // Otherwise, show Accept & Decline buttons
                else ...[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isDeclined = true; // Switch to counter-offer UI
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDCF5ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Decline", style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserInfoDone(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF45B28F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Accept", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const Divider(),

          // Chat Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: chatMessages.map((msg) => buildChatBubble(msg, isUser: true)).toList(),
            ),
          ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Write here",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF45B28F)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Chat Bubble Widget
  Widget buildChatBubble(String message, {bool isUser = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isUser ? Colors.green : Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
