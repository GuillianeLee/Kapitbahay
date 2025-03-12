import 'package:flutter/material.dart';

class ServiceCompletionForm extends StatefulWidget {
  const ServiceCompletionForm({super.key});

  @override
  _ServiceCompletionFormState createState() => _ServiceCompletionFormState();
}

class _ServiceCompletionFormState extends State<ServiceCompletionForm> {
  String? _completionStatus;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _baseFeeController = TextEditingController();
  final TextEditingController _itemCostController = TextEditingController();
  final TextEditingController _effortFeeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "Service Not Fully Done?",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Completion Status
                  const Text("Completion Status", style: TextStyle(fontSize: 16)),
                  Column(
                    children: [
                      buildRadioOption("Fully Completed"),
                      buildRadioOption("Partially Completed"),
                      buildRadioOption("Not Completed"),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Proof Upload Placeholder
                  const Text("Proof (If applicable)", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, color: Colors.blue, size: 30),
                          TextButton(
                            onPressed: () {}, // Add file upload logic
                            child: const Text(
                              "Link or drag and drop",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          const Text(".xlsx (max. 3MB)", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Reason Input
                  const Text("Reason (for Partial Completion/Not Complete)", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _reasonController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Payment Adjustments Section
                  const Text("Payment Adjustments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),

                  buildInputField("Base Fee (Effort & Transport)", _baseFeeController),
                  buildInputField("Item Cost (Not charged if unavailable)", _itemCostController),
                  buildInputField("Additional Effort Fee (Optional, Implies extra time or effort was needed)", _effortFeeController),
                  const SizedBox(height: 80), // Extra space before fixed button
                ],
              ),
            ),
          ),

          // Fixed "Next" Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(69, 178, 143, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Radio Option Widget
  Widget buildRadioOption(String label) {
    return RadioListTile<String>(
      title: Text(label),
      value: label,
      groupValue: _completionStatus,
      onChanged: (value) {
        setState(() {
          _completionStatus = value;
        });
      },
      activeColor: Colors.green,
    );
  }

  // Input Field Widget
  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "PHP",
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
