import 'package:flutter/material.dart';
import 'package:smart_tracking/services/student/paymentapi.dart';

class PaymentPage extends StatefulWidget {
  final amount;
  final id;

  const PaymentPage({super.key, this.amount, this.id});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
 
  String station = "Station A"; // Example value for Station
  DateTime? selectedDate = DateTime.now(); // Example value for Date

  void _submitPayment()async {
    await makepaymentApi({
      'id':widget.id,
    },context);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Payment Successful\nAmount: ${widget.amount}, Date: ${selectedDate.toString().split(" ")[0]}, Station: $station"),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container with Fields
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Amount: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.amount.toString()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Date: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(selectedDate.toString().split(" ")[0]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Station: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(station),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Pay Button
            Center(
              child: ElevatedButton(
                onPressed: _submitPayment,
                child: const Text("Pay"),
              ),
            ),
          ],
        ),
     ),
);
}
}