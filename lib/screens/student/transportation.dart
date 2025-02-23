import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/student/makepayment.dart';
import 'package:smart_tracking/services/loginapi.dart';
import 'package:smart_tracking/services/parent/getbusentryapi.dart';
import 'package:smart_tracking/services/parent/parentprofileapi.dart';
import 'package:smart_tracking/services/student/getfeesdueapi.dart';
import 'package:smart_tracking/services/student/getfineapi.dart';
import 'package:smart_tracking/services/student/gettpaymenthistoryapi.dart';
import 'package:smart_tracking/services/student/studentprofileapi.dart';

class TransportationScreen extends StatefulWidget {
  const TransportationScreen({super.key});

  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  String selectedField = 'Fees Due'; // Default selected field
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }



  Future<void> fetch() async {
    if (selectedField == 'Fees Due') {
      data = await getfeesdueAPI( userType == 'user' ? lid : parentprofileData['students'][0]['id']);
    } else if (selectedField == 'Payment History') {
      data = await getpaymenthistoryAPI( userType == 'user' ? lid : parentprofileData['students'][0]['id']);
    }else if (selectedField == 'Entry/Exit') {
      data = await getentryAPI(parentprofileData['students'][0]['id']);
    }
    
     else {
      data = await getfineAPI(
          userType == 'user' ? lid : parentprofileData['students'][0]['id']);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transportation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student profile section
            if (userType != 'parent')
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        '$imageurl${studentprofileData['student_image']}'), // Replace with student image
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentprofileData['Name'] ?? "no name",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        studentprofileData['admissionno'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // Navigation fields (Fees Due, Payment History, Fine)
          SingleChildScrollView(
  scrollDirection: Axis.horizontal, // Enables horizontal scrolling
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // Avoids stretching elements
    children: [
      _buildOption("Fees Due"),
      const SizedBox(width: 10), // Adds spacing between options
      _buildOption("Payment History"),
      const SizedBox(width: 10),
      _buildOption("Fine"),
      if (userType == 'parent') ...[
        const SizedBox(width: 10),
        _buildOption('Entry/Exit'),
      ],
    ],
  ),
),

            const SizedBox(height: 20),

            // Dynamic content based on selected field
            Expanded(
              child: SingleChildScrollView(
                child: selectedField == 'Fees Due'
                    ? _buildFeesDueContent(data)
                    : selectedField == 'Payment History'
                        ? _buildPaymentHistoryContent(data)
                        : selectedField == 'Entry/Exit'
                            ? _buildentryExidata(data)
                            : _buildFineContent(data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build an option button
  Widget _buildOption(String title) {
    return GestureDetector(
      onTap: () async {
        selectedField = title;
        await fetch();
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: selectedField == title ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedField == title ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Content for Fees Due
  Widget _buildFeesDueContent(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 200,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
              'Date: ${data[index]['date'].toString().substring(0,10)}',
              style: const TextStyle(fontSize: 16),
                      ),
                  Text(
              data[index]['message'],
              style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                       Text(
              "Due Amount: ${data[index]['amount']??"0"}",
              style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>PaymentPage(amount:data[index]['amount'],id:data[index]['id'] ,)));
                  // Handle make payment action
                },
                child: const Text("Make Payment"),
              ),
                      ),
              ],),
            ),
          );
        },))
       
      ],
    );
  }

  Widget _buildentryExidata(data) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Entry", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Exit", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Station", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Example data
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${index + 1}"),
                 Text(data[index]['date'].toString().substring(0,10)),
                 Text(data[index]['entrytime'].toString()),
                 Text(data[index]['exittime'].toString()),
                 Text(data[index]['entrylat'].toString()),
               
              ],
            );
          },
        ),
      ],
    );
  }

  // Content for Payment History
  Widget _buildPaymentHistoryContent(data) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
            // Text("Mode", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
            // Text("Challan No", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length, // Example data
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${index + 1}"),
                 Text(data[index]['date'].toString().substring(0,10)),
                // const Text("Online"),
                 Text(data[index]['amount'].toString()),
                // const Text("CH12345"),
              ],
            );
          },
        ),
      ],
    );
  }

  // Content for Fine
  Widget _buildFineContent(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data[0]['date'].toString().substring(0, 10),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          "Reason: ${data[0]['reason']}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          "Amount: ${data[0]['amount']}",
          style: const TextStyle(fontSize: 16),
        ),
        // const SizedBox(height: 20),
        // Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       // Handle make payment action
        //     },
        //     child: const Text("Make Payment"),
        //   ),
        // ),
      ],
    );
  }
}
