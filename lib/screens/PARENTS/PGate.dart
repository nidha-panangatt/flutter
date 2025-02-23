// import 'package:flutter/material.dart';

// class PGateScreen extends StatefulWidget {
//   const PGateScreen({super.key});

//   @override
//   _PGateScreenState createState() => _PGateScreenState();
// }

// class _PGateScreenState extends State<PGateScreen> {
//   DateTime? fromDate;
//   DateTime? toDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Gate",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF1C1C55),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
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
//             const Text(
//               "Recent Check-In/Out",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       prefixIcon: const Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     _showCustomDateFilterDialog();
//                   },
//                   icon: const Icon(Icons.filter_list),
//                   label: const Text("Filter"),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCustomDateFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: StatefulBuilder(
//             builder: (context, setState) => Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     "Custom Date",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           const Text("From"),
//                           const SizedBox(height: 10),
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: fromDate ?? DateTime.now(),
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2100),
//                               );
//                               if (pickedDate != null) {
//                                 setState(() {
//                                   fromDate = pickedDate;
//                                 });
//                               }
//                             },
//                             icon: const Icon(Icons.calendar_today, size: 16),
//                             label: Text(fromDate == null
//                                 ? "Select"
//                                 : fromDate!.toLocal().toShortDateString()),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text("To"),
//                           const SizedBox(height: 10),
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: toDate ?? DateTime.now(),
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2100),
//                               );
//                               if (pickedDate != null) {
//                                 setState(() {
//                                   toDate = pickedDate;
//                                 });
//                               }
//                             },
//                             icon: const Icon(Icons.calendar_today, size: 16),
//                             label: Text(toDate == null
//                                 ? "Select"
//                                 : toDate!.toLocal().toShortDateString()),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         if (fromDate != null && toDate != null) {
//                           Navigator.pop(context);
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Filtered from ${fromDate!.toLocal().toShortDateString()} to ${toDate!.toLocal().toShortDateString()}",
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: const Text(
//                         "Done",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.purple,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension DateTimeExtensions on DateTime {
//   String toShortDateString() {
//     return "$day/$month/$year";
//   }
// }
