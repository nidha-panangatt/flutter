// import 'package:flutter/material.dart';

// class PNotificationScreen extends StatefulWidget {
//   const PNotificationScreen({super.key});

//   @override
//   State<PNotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<PNotificationScreen> {
//   String selectedFilter = "All"; // Default filter option

//   final List<Map<String, String>> notifications = [
//     {"type": "Entry/Exit", "message": "Entry at 9:00 AM", "dateTime": "Today"},
//     {"type": "Entry/Exit", "message": "Exit at 5:00 PM", "dateTime": "Yesterday"},
//     {"type": "Unauthorized Entry", "message": "Unauthorized access detected", "dateTime": "Yesterday"},
//     {"type": "Fine", "message": "Fine issued: \$50", "dateTime": "Last Week"},
//     {"type": "Fine", "message": "Fine issued: \$100", "dateTime": "Today"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // Filtered Notifications
//     final filteredNotifications = selectedFilter == "All"
//         ? notifications
//         : notifications.where((item) => item["type"] == selectedFilter).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Notifications",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF1C1C55),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             // Navigate to Home Screen
//             Navigator.pushReplacementNamed(context, '/home');
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list, color: Colors.white),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         title: const Text("All"),
//                         onTap: () {
//                           setState(() => selectedFilter = "All");
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         title: const Text("Entry/Exit"),
//                         onTap: () {
//                           setState(() => selectedFilter = "Entry/Exit");
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         title: const Text("Unauthorized Entry"),
//                         onTap: () {
//                           setState(() => selectedFilter = "Unauthorized Entry");
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         title: const Text("Fine"),
//                         onTap: () {
//                           setState(() => selectedFilter = "Fine");
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Filter Display
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             width: double.infinity,
//             color: Colors.grey[200],
//             child: Text(
//               "Filter: $selectedFilter",
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//           // Notification List
//           Expanded(
//             child: filteredNotifications.isEmpty
//                 ? const Center(
//                     child: Text(
//                       "No notifications available",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: filteredNotifications.length,
//                     itemBuilder: (context, index) {
//                       final notification = filteredNotifications[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 8.0,
//                           horizontal: 16.0,
//                         ),
//                         child: ListTile(
//                           leading: Icon(
//                             notification["type"] == "Entry/Exit"
//                                 ? Icons.login
//                                 : notification["type"] == "Unauthorized Entry"
//                                     ? Icons.warning
//                                     : Icons.money,
//                             color: Colors.blue,
//                           ),
//                           title: Text(notification["message"]!),
//                           subtitle: Text(notification["dateTime"]!),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: const PNotificationScreen(),
//     routes: {
//       '/home': (context) => const HomeScreen(),
//       '/account': (context) => const AccountScreen(),
//     },
//   ));
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Home")),
//       body: const Center(child: Text("Home Screen")),
//     );
//   }
// }

// class AccountScreen extends StatelessWidget {
//   const AccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Account")),
//       body: const Center(child: Text("Account Screen")),
//     );
//   }
// }