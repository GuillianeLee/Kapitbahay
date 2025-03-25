import 'package:flutter/material.dart';
import '/firebase/firestore.dart';
import 'description.dart';

class TaskSelectionScreen extends StatelessWidget {
  final String categoryTitle;
  final List<String> categories = [
    "Picking up",
    "Delivery",
    "Queuing",
    "Drop offs",
    "Others",
  ];
  final DatabaseService _databaseService = DatabaseService();

  TaskSelectionScreen({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStep("Task", true),
                _buildStep("Description", false),
                _buildStep("Details", false),
                _buildStep("Location", false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: const Text(
              "Select a category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // Category List
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    try {
                      // Create a new task in Firestore and get the taskId
                      String? taskId = await _databaseService.addTask(categories[index]);
                      if (taskId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskFormScreen(
                              selectedCategory: categories[index],
                              taskId: taskId,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      print("Error adding task: $e");
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: isActive ? const Color(0xFF45B28F) : Colors.grey,
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
}
