import 'package:flutter/material.dart';
import 'chatif.dart';

class OfferPopup extends StatelessWidget {
  const OfferPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Row (Avatar + Details)
            Row(
              children: [
                // Profile Image on the Left
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Replace with actual image
                ),
                const SizedBox(width: 12),

                // User Details on the Right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Guillermo Raby",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),

                      Row(
                        children: const [
                          Icon(Icons.phone, color: Color(0xFF45B28F), size: 18),
                          SizedBox(width: 5),
                          Text("0912 678 8919"),
                        ],
                      ),
                      const SizedBox(height: 5),

                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.blue, size: 18),
                          SizedBox(width: 5),
                          Text("FEU Alabang"),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Rating and Profile Link
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 18),
                          const SizedBox(width: 4),
                          const Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {}, // Navigate to profile
                            child: const Text("view profile", style: TextStyle(color: Color(0xFF45B28F))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Offer Price
            const Text(
              "Offer: PHP 1,000",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Buttons (Cancel & Chat)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Close popup
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDCF5ED),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ChatOfferScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF45B28F),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Chat", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
