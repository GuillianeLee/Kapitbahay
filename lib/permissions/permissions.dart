import 'package:flutter/material.dart';
import '/permissions/location.dart';

class LocationPermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Allow Kapitbahay to access this device’s location?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),

            // Maps Preview
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMapPreview(),
                SizedBox(width: 10),
                _buildMapPreview(),
              ],
            ),
            SizedBox(height: 20),

            // Buttons
            /* _buildButton(context, 'WHILE USING THE APP', () {
              Navigator.pop(context, 'whileUsing');
            }),*/

            _buildButton(context, 'WHILE USING THE APP', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationWidget()),
              );
            }),
            SizedBox(height: 10),
            _buildButton(context, 'ONLY THIS TIME', () {
              Navigator.pop(context, 'onlyThisTime');
            }),
            SizedBox(height: 10),
            _buildButton(context, 'DON’T ALLOW', () {
              Navigator.pop(context, 'deny');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(Icons.map, size: 40, color: Colors.grey[600]), // Placeholder
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(69, 178, 143, 1),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// Dialog
void showLocationPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => LocationPermissionDialog(),
  ).then((value) {
    print("User selected: $value");
  });
}


