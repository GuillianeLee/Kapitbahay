import 'package:flutter/material.dart';
import 'reciept.dart';

class UserInfoDone extends StatelessWidget {
  const UserInfoDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                    ),
                    const SizedBox(width: 10),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Sydney O.",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              const Icon(Icons.star, color: Colors.orange, size: 18),
                              const SizedBox(width: 4),
                              const Text(
                                "4.8",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.phone, color: Colors.green, size: 18),
                              SizedBox(width: 5),
                              Text("0912 678 8919", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.location_on, color: Colors.blue, size: 18),
                              SizedBox(width: 5),
                              Text("Azure Beach", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {}, // Insert task details logic
                            child: const Text(
                              "View Task Details",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Use Navigator.push instead of showDialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReceiptScreen(), //New Receipt Screen
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(69, 178, 143, 1),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color.fromRGBO(69, 178, 143, 1), width: 2.0),
                          ),
                        ),
                        child: const Text(
                          "Task Done",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
