import 'package:flutter/material.dart';
import '/task/tasklocation.dart';
import '/location/locationsearch.dart';

class TaskDetailsBudgetScreen extends StatefulWidget {
  @override
  _TaskDetailsBudgetScreenState createState() => _TaskDetailsBudgetScreenState();
}

class _TaskDetailsBudgetScreenState extends State<TaskDetailsBudgetScreen> {
  int kapitbahayNeeded = 1; // add logic pa
  TextEditingController budgetController = TextEditingController();
  TextEditingController additionalCostController = TextEditingController();
  bool isNegotiable = false;
  String paymentType = "One-time payment"; // Default
  String paymentMethod = "Cash upon task complete"; // Default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStep("Task", false),
                  _buildStep("Description", false),
                  _buildStep("Details", true),
                  _buildStep("Location", false),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "Tell us more",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "Skills and Experiences (optional)",
                style: TextStyle(fontSize: 12),
              ),
              TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              const Text("No. kapitbahay needed", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildCounterButton(Icons.remove, () {
                    setState(() {
                      if (kapitbahayNeeded > 1) kapitbahayNeeded--;
                    });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "$kapitbahayNeeded",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildCounterButton(Icons.add, () {
                    setState(() {
                      kapitbahayNeeded++;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 20),

              // Budget Input
              _buildTextField(
                  "How much are you willing to pay?", budgetController),
              _buildCheckbox("Budget can be negotiable", isNegotiable, (value) {
                setState(() {
                  isNegotiable = value!;
                });
              }),
              const SizedBox(height: 20),

              // Additional cost input
              _buildTextField(
                "Additional cost like purchasing product or travel expenses etc? (if any)",
                additionalCostController,
              ),
              const SizedBox(height: 20),

              // Payment type selection
              const Text(
                  "Is your budget based on one-time payment or an hourly rate?",
                  style: TextStyle(fontSize: 16)),
              _buildPaymentTypeRadio("One-time payment"),
              _buildPaymentTypeRadio("Hourly rate"),
              const SizedBox(height: 20),

              // Payment method selection
              const Text("Payment Method", style: TextStyle(fontSize: 16)),
              _buildPaymentMethodRadio("Cash upon task complete"),
              _buildPaymentMethodRadio("E-wallet"),
              const SizedBox(height: 20),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationSelectionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // progress indicator
  Widget _buildStep(String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: isActive ? Colors.green : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  // counter button
  Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 24),
      ),
    );
  }

  // text input
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            prefixText: "PHP ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Checkbox option
  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  // Radio button for Payment Type
  Widget _buildPaymentTypeRadio(String label) {
    return Row(
      children: [
        Radio(
          value: label,
          groupValue: paymentType,
          onChanged: (value) {
            setState(() {
              paymentType = value as String;
            });
          },
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  // Radio button for Payment Method
  Widget _buildPaymentMethodRadio(String label) {
    return Row(
      children: [
        Radio(
          value: label,
          groupValue: paymentMethod,
          onChanged: (value) {
            setState(() {
              paymentMethod = value as String;
            });
          },
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
