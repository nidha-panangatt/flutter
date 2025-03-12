// import 'package:flutter/material.dart';
// import 'package:smart_tracking/screens/student/makepayment.dart';
// import 'package:smart_tracking/services/loginapi.dart';
// import 'package:smart_tracking/services/parent/getbusentryapi.dart';
// import 'package:smart_tracking/services/parent/parentprofileapi.dart';
// import 'package:smart_tracking/services/student/getfeesdueapi.dart';
// import 'package:smart_tracking/services/student/getfineapi.dart';
// import 'package:smart_tracking/services/student/gettpaymenthistoryapi.dart';
// import 'package:smart_tracking/services/student/studentprofileapi.dart';

// class TransportationScreen extends StatefulWidget {
//   const TransportationScreen({super.key});

//   @override
//   _TransportationScreenState createState() => _TransportationScreenState();
// }

// class _TransportationScreenState extends State<TransportationScreen> {
//   String selectedField = 'Fees Due'; // Default selected field
//   List<Map<String, dynamic>> data = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetch();
//   }



//   Future<void> fetch() async {
//     if (selectedField == 'Fees Due') {
//       data = await getfeesdueAPI( userType == 'user' ? lid : parentprofileData['students'][0]['id']);
//     } else if (selectedField == 'Payment History') {
//       data = await getpaymenthistoryAPI( userType == 'user' ? lid : parentprofileData['students'][0]['id']);
//     }else if (selectedField == 'Entry/Exit') {
//       data = await getentryAPI(parentprofileData['students'][0]['id']);
//     }
    
//      else {
//       data = await getfineAPI(
//           userType == 'user' ? lid : parentprofileData['students'][0]['id']);
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Transportation"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navigate back
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Student profile section
//             if (userType != 'parent')
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                         '$imageurl${studentprofileData['student_image']}'), // Replace with student image
//                   ),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         studentprofileData['Name'] ?? "no name",
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         studentprofileData['admissionno'].toString(),
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 20),

//             // Navigation fields (Fees Due, Payment History, Fine)
//           SingleChildScrollView(
//   scrollDirection: Axis.horizontal, // Enables horizontal scrolling
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.start, // Avoids stretching elements
//     children: [
//       _buildOption("Fees Due"),
//       const SizedBox(width: 10), // Adds spacing between options
//       _buildOption("Payment History"),
//       const SizedBox(width: 10),
//       _buildOption("Fine"),
//       if (userType == 'parent') ...[
//         const SizedBox(width: 10),
//         _buildOption('Entry/Exit'),
//       ],
//     ],
//   ),
// ),

//             const SizedBox(height: 20),

//             // Dynamic content based on selected field
//             Expanded(
//               child: SingleChildScrollView(
//                 child: selectedField == 'Fees Due'
//                     ? _buildFeesDueContent(data)
//                     : selectedField == 'Payment History'
//                         ? _buildPaymentHistoryContent(data)
//                         : selectedField == 'Entry/Exit'
//                             ? _buildentryExidata(data)
//                             : _buildFineContent(data),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget to build an option button
//   Widget _buildOption(String title) {
//     return GestureDetector(
//       onTap: () async {
//         selectedField = title;
//         await fetch();
//         setState(() {});
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         decoration: BoxDecoration(
//           color: selectedField == title ? Colors.blue : Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: selectedField == title ? Colors.white : Colors.black,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   // Content for Fees Due
//   Widget _buildFeesDueContent(data) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 200,
//           child: ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                  Text(
//               'Date: ${data[index]['date'].toString().substring(0,10)}',
//               style: const TextStyle(fontSize: 16),
//                       ),
//                   Text(
//               data[index]['message'],
//               style: const TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 10),
//                        Text(
//               "Due Amount: ${data[index]['amount']??"0"}",
//               style: const TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 20),
//                       Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>PaymentPage(amount:data[index]['amount'],id:data[index]['id'] ,)));
//                   // Handle make payment action
//                 },
//                 child: const Text("Make Payment"),
//               ),
//                       ),
//               ],),
//             ),
//           );
//         },))
       
//       ],
//     );
//   }

//   Widget _buildentryExidata(data) {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Entry", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Exit", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Station", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const Divider(),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 5, // Example data
//           itemBuilder: (context, index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("${index + 1}"),
//                 if(data[index]['date']!=null)
//                  Text(data[index]['date'].toString()),
//                  if(data[index]['entrytime']!=null)
//                  Text(data[index]['entrytime'].toString()),
//                   if(data[index]['exittime']!=null)
//                  Text(data[index]['exittime'].toString()),
//                   if(data[index]['entrylat']!=null)
//                  Text(data[index]['entrylat'].toString()),
               
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   // Content for Payment History
//   Widget _buildPaymentHistoryContent(data) {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
//             // Text("Mode", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
//             // Text("Challan No", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const Divider(),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: data.length, // Example data
//           itemBuilder: (context, index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("${index + 1}"),
//                  Text(data[index]['date'].toString().substring(0,10)),
//                 // const Text("Online"),
//                  Text(data[index]['amount'].toString()),
//                 // const Text("CH12345"),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   // Content for Fine
  // Widget _buildFineContent(data) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         data[0]['date'].toString().substring(0, 10),
  //         style: const TextStyle(fontSize: 16),
  //       ),
  //       const SizedBox(height: 10),
  //       Text(
  //         "Reason: ${data[0]['reason']}",
  //         style: const TextStyle(fontSize: 16),
  //       ),
  //       const SizedBox(height: 10),
  //       Text(
  //         "Amount: ${data[0]['amount']}",
  //         style: const TextStyle(fontSize: 16),
  //       ),
  //       // const SizedBox(height: 20),
  //       // Center(
  //       //   child: ElevatedButton(
  //       //     onPressed: () {
  //       //       // Handle make payment action
  //       //     },
  //       //     child: const Text("Make Payment"),
  //       //   ),
  //       // ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/student/makepayment.dart';
import 'package:smart_tracking/services/loginapi.dart';
import 'package:smart_tracking/services/student/getfeesdueapi.dart';
import 'package:smart_tracking/services/student/getfineapi.dart';
import 'package:smart_tracking/services/student/gettpaymenthistoryapi.dart';
import 'package:smart_tracking/services/parent/getbusentryapi.dart';

class TransportationScreen extends StatefulWidget {
  final id;
  const TransportationScreen({super.key, this.id});

  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  String selectedField = ''; // No default selection
  List<Map<String, dynamic>> data = [];
  bool isLoading = false; // Tracks API call status

  Future<void> fetch(String field) async {
    setState(() {
      isLoading = true;
      selectedField = field;
    });

    List<Map<String, dynamic>> fetchedData = [];

    if (field == 'Fees Due') {
      fetchedData = await getfeesdueAPI(userType == 'parent'?widget.id: lid) ?? [];
    } else if (field == 'Payment History') {
      fetchedData = await getpaymenthistoryAPI(userType == 'parent'?widget.id: lid) ?? [];
    } else if (field == 'Entry/Exit') {
      fetchedData = await getentryAPI(userType == 'parent'?widget.id: lid) ?? [];
    } else {
      fetchedData = await getfineAPI(userType == 'parent'?widget.id: lid) ?? [];
    }

    setState(() {
      data = fetchedData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transportation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildOption("Fees Due"),
                  const SizedBox(width: 10),
                  _buildOption("Payment History"),
                  const SizedBox(width: 10),
                  _buildOption("Fine"),
                  const SizedBox(width: 10),
                  _buildOption("Entry/Exit"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Show Loading Indicator
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (selectedField.isEmpty)
              const Center(child: Text("Select an option to fetch data."))
            else
              // Dynamic content based on selected field
              Expanded(
                child: SingleChildScrollView(
                  child: selectedField == 'Fees Due'
                      ? _buildFeesDueContent()
                      : selectedField == 'Payment History'
                          ? _buildPaymentHistoryContent()
                          : selectedField == 'Entry/Exit'
                              ? _buildEntryExitContent()
                              : _buildFineContent(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Option buttons
  Widget _buildOption(String title) {
    return GestureDetector(
      onTap: () async {
        await fetch(title); // API call only when clicked
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

  // Fees Due content
  Widget _buildFeesDueContent() {
    if (data.isEmpty) {
      return Center(child: Text("No Fees Due"));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: ${data[index]['date'].toString().substring(0, 10)}"),
                Text(data[index]['message'] ?? "No Message"),
                const SizedBox(height: 10),
                Text("Due Amount: ${data[index]['amount'] ?? "0"}"),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctxt) => PaymentPage(
                            amount: data[index]['amount'],
                            id: data[index]['id'],
                          ),
                        ),
                      );
                    },
                    child: const Text("Make Payment"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Payment History content
  Widget _buildPaymentHistoryContent() {
    if (data.isEmpty) {
      return Center(child: Text("No Payment History"));
    }
    return Column(
      children: data.map((entry) {
        return ListTile(
          title: Text("Date: ${entry['date'].toString().substring(0, 10)}"),
          subtitle: Text("Amount: ${entry['amount']}"),
        );
      }).toList(),
    );
  }

  // Entry/Exit Content
  Widget _buildEntryExitContent() {
    if (data.isEmpty) {
      return Center(child: Text("No Entry/Exit Data"));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Entry Time", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Exit Time", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(),
        ...data.map((entry) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(entry['date'].toString()),
              Text(entry['entrytime'] ?? "-"),
              Text(entry['exittime'] ?? "-"),
            ],
          );
        }).toList(),
      ],
    );
  }

  // Fine Content
  Widget _buildFineContent() {
    if (data.isEmpty) {
      return Center(child: Text("No Fines"));
    }
    return Column(
      children: data.map((entry) {
        return ListTile(
          title: Text("Date: ${entry['date'].toString().substring(0, 10)}"),
          subtitle: Text("Reason: ${entry['reason']}\nAmount: ${entry['amount']}"),
        );
      }).toList(),
    );
  }
}
