import 'package:flutter/material.dart';
import '/task/details.dart';
import '/firebase/firestore.dart';

class TaskFormScreen extends StatefulWidget {
  final String selectedCategory;
  final String taskId; // taskID

  const TaskFormScreen({Key? key, required this.selectedCategory, required this.taskId}) : super(key: key);

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool isUrgent = false;
  final DatabaseService _databaseService = DatabaseService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveTaskDetails() async {
    try {
      String formattedDate = _selectedDate != null ? _selectedDate.toString().split(" ")[0] : "Not set";
      String formattedTime = _selectedTime != null ? _selectedTime!.format(context) : "Not set";

      // update Firestore
      Map<String, dynamic> taskData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'date': formattedDate,
        'time': formattedTime,
        'isUrgent': isUrgent,
      };

      await _databaseService.updateTask(widget.taskId, taskData);

      // next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailsBudgetScreen(taskId: widget.taskId),
        ),
      );
    } catch (e) {
      print("Error updating task: $e");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Form - ${widget.selectedCategory}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStep("Task", false),
                    _buildStep("Description", true),
                    _buildStep("Details", false),
                    _buildStep("Location", false),
                  ],
                ),
              ),
              Text(
                "What task can we help you with today?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Request Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.black),
                title: Text(
                  _selectedDate != null
                      ? "Target Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}"
                      : "Select target date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _selectedDate != null
                        ? Color.fromRGBO(69, 178, 143, 1) // ✅ Applies custom color if date is selected
                        : Colors.black, // Default color for placeholder
                  ),
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),

              ListTile(
                leading: Icon(Icons.access_time, color: Colors.black),
                title: Text(
                  _selectedTime != null
                      ? "Target Time: ${_selectedTime!.format(context)}"
                      : "Enter target time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _selectedTime != null
                        ? Color.fromRGBO(69, 178, 143, 1)
                        : Colors.black,
                  ),
                ),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                  );

                  if (picked != null && picked != _selectedTime) {
                    setState(() {
                      _selectedTime = picked;
                    });
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Urgent", style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isUrgent,
                    onChanged: (val) {
                      setState(() {
                        isUrgent = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTaskDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
