import 'package:flutter/material.dart';
import '/negotiable/tasknotcomplete.dart';
import '/task/taskrating.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // White Card for Payment Details
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Editable Partial Payment",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  buildDetailRow("Date", "Dec. 18, 2025"),
                  buildDetailRow("Transaction ID", "12743DHA802YC"),
                  buildDetailRow("Customer Name", "Juan Dela Cruz"),
                  buildDetailRow("Service Location", "SM Bicutan"),
                  const SizedBox(height: 8),
                  buildDetailRow("KapitBuddy Name", "Guillermo Raby"),
                  buildDetailRow("KapitBuddy Contact", "0912 678 8919"),
                  const SizedBox(height: 8),
                  buildDetailRow("Service Rendered", "Running Errands"),
                  buildDetailRow("Payment Method", "Cash upon task complete"),
                  const Divider(),
                  buildDetailRow("Task", "P 750.00"),
                  buildDetailRow("Additional Fee", "P 50.00"),
                  buildDetailRow("Service Fee", "P 10.00"),
                  const Divider(),
                  buildTotalRow("Total", "P 810.00"),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(
                        "Edit",
                        Color(0xFFDCF5ED),
                        Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ServiceCompletionForm()),
                          );
                        },
                      ),
                      buildButton(
                        "Done",
                        Color(0xFF45B28F),
                        Colors.white,
                        onPressed: () {
                          String userName = "Guillermo Raby"; // Dynamic username
                          String userImage = "https://via.placeholder.com/150"; // Example image URL

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingPopup(
                                userName: userName,
                                userImage: userImage,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget buildTotalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildButton(String text, Color color, Color textColor, {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}
