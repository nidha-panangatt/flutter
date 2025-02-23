// import 'package:flutter/material.dart';
// import 'package:smart_tracking/services/parent/getbusentryapi.dart';
// import 'package:smart_tracking/services/student/getfeesdueapi.dart';
// import 'package:smart_tracking/services/student/getfineapi.dart';
// import 'package:smart_tracking/services/student/gettpaymenthistoryapi.dart';

// class PTransportation extends StatefulWidget {
//   const PTransportation({super.key});

//   @override
//   _PTransportationState createState() => _PTransportationState();
// }

// class _PTransportationState extends State<PTransportation> {
//   String selectedField = 'Payment History'; // Default selected field

//   List<Map<String,dynamic>>data=[];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetch();
//   }

//  Future< void> fetch()async{

//     if (selectedField=='Fees Due') {
//       data=await getfeesdueAPI();
      
//     }else  if (selectedField=='Payment History') {
//        data=await getpaymenthistoryAPI();
//     }else if (selectedField=='Entry/Exit') {
//        data=await getentryAPI();
//     }
    
//     else{
//  data=await getfineAPI();
//     }

// setState(() {
  
// });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Transportation",
//           style: TextStyle(
//             color: Colors.white, // Change text color to white
//           ),
//         ),
//         backgroundColor: const Color(0xFF1C1C55), // Set AppBar color
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white), // Set icon color to white
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildOption("Payment History"),
//                 _buildOption("Fees Due"),
//                 _buildOption("Fine"),
//                 _buildOption("Entry/Exit"),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: selectedField == 'Payment History'
//                     ? _buildPaymentHistoryContent()
//                     : selectedField == 'Fees Due'
//                         ? _buildFeesDueContent()
//                         : selectedField == 'Fine'
//                             ? _buildFineContent()
//                             : _buildEntryExitContent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOption(String title) {
//     return GestureDetector(
//       onTap: ()async {
//          selectedField = title;
//          await fetch();
//         setState(() {
         
          
//         });
//       },
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: selectedField == title ? Colors.black : Colors.grey,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 5), // Add spacing between text and underline
//           if (selectedField == title)
//             Container(
//               height: 2, // Thickness of the underline
//               width: 60, // Width of the underline
//               color: Colors.blue, // Underline color
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentHistoryContent() {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const Divider(),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 1, // Reduced to 1 item for demo
//           itemBuilder: (context, index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("${index + 1}"),
//                 const Text("01-Dec-2024"),
//                 const Text("1000"),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildFeesDueContent() {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Payment", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const Divider(),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("1"),
//             const Text("01-Dec-2024"),
//             ElevatedButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Pay Clicked!")),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10), // Set border radius
//                 ),
//               ),
//               child: const Text("Pay"), // Change text to "Pay"
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildFineContent() {
//     return Column(
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width, // Set the width to full screen width
//           child: Card(
//             margin: const EdgeInsets.symmetric(vertical: 10),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Reason: Fine Reason 1", style: TextStyle(fontSize: 16)),
//                   const SizedBox(height: 10),
//                   const Text("Date: 01-Dec-2024", style: TextStyle(fontSize: 16)),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Pay Fine Clicked!")),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10), // Set border radius
//                       ),
//                     ),
//                     child: const Text("Make Payment"), // Button text
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEntryExitContent() {
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Route", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Station", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Entry/Exit", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const Divider(),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 1, // Reduced to 1 item for demo
//           itemBuilder: (context, index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("${index + 1}"),
//                 const Text("01-Dec-2024"),
//                 const Text("Route A"),
//                 const Text("Station 1"),
//                 const Text("Entry"),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }