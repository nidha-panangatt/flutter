import 'package:flutter/material.dart';
import 'package:smart_tracking/services/student/getnotificationapi.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // String selectedFilter = "All"; // Default filter option

  // final List<Map<String, String>> notifications = [
  //   {"type": "Entry/Exit", "message": "Entry at 9:00 AM", "dateTime": "Today"},
  //   {"type": "Entry/Exit", "message": "Exit at 5:00 PM", "dateTime": "Yesterday"},
  //   {"type": "Unauthorized Entry", "message": "Unauthorized access detected", "dateTime": "Yesterday"},
  //   {"type": "Fine", "message": "Fine issued: \$50", "dateTime": "Last Week"},
  //   {"type": "Fine", "message": "Fine issued: \$100", "dateTime": "Today"},
  // ];

  @override
  Widget build(BuildContext context) {
    // Filtered Notifications
    // final filteredNotifications = selectedFilter == "All"
    //     ? notifications
    //     : notifications.where((item) => item["type"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.filter_list),
        //     onPressed: () {
        //       showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               ListTile(
        //                 title: const Text("All"),
        //                 onTap: () {
        //                   setState(() => selectedFilter = "All");
        //                   Navigator.pop(context);
        //                 },
        //               ),
        //               ListTile(
        //                 title: const Text("Entry/Exit"),
        //                 onTap: () {
        //                   setState(() => selectedFilter = "Entry/Exit");
        //                   Navigator.pop(context);
        //                 },
        //               ),
        //               ListTile(
        //                 title: const Text("Unauthorized Entry"),
        //                 onTap: () {
        //                   setState(() => selectedFilter = "Unauthorized Entry");
        //                   Navigator.pop(context);
        //                 },
        //               ),
        //               ListTile(
        //                 title: const Text("Fine"),
        //                 onTap: () {
        //                   setState(() => selectedFilter = "Fine");
        //                   Navigator.pop(context);
        //                 },
        //               ),
        //             ],
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Filter Display
          // Container(
          //   padding: const EdgeInsets.all(8.0),
          //   width: double.infinity,
          //   color: Colors.grey[200],
          //   child: Text(
          //     "Filter: $selectedFilter",
          //     style: const TextStyle(fontSize: 16),
          //   ),
          // ),
          // Notification List
          Expanded(
            child: studentNotifications.isEmpty
                ? const Center(
                    child: Text(
                      "No notifications available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: studentNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = studentNotifications[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ListTile(
                          // leading: Icon(
                          //   notification["type"] == "Entry/Exit"
                          //       ? Icons.login
                          //       : notification["type"] == "Unauthorized Entry"
                          //           ? Icons.warning
                          //           : Icons.money,
                          //   color: Colors.blue,
                          // ),
                          leading: const Icon(Icons.notifications_active),
                          title: Text(notification["message"] ?? 'unknown'),
                          subtitle: Text(notification["date"].toString().substring(0,10)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
     
    );
  }
}