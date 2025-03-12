import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Payment Methods',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _buildPaymentMethodTile('Add payment method', context),
            Divider(),
            _buildPaymentMethodTile('Add gcash', context),
            Divider(),
            // Add more if possible
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String title, BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (title == 'Add payment method') {
          print('Navigate to Add Payment Method screen');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPaymentMethodScreen()));
        } else if (title == 'Add gcash') {
          print('Navigate to Add GCash screen');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddGCashScreen()));
        }
      },
    );
  }
}

//Placeholders
class AddPaymentMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Payment Method')),
      body: Center(child: Text('Add Payment Method Screen')),
    );
  }
}

class AddGCashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add GCash')),
      body: Center(child: Text('Add GCash Screen')),
    );
  }
}