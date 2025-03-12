import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/Ploginpage.dart';
import 'package:smart_tracking/services/parent/parentprofileapi.dart';

class PAccount extends StatefulWidget {
  const PAccount({super.key});

  @override
  State<PAccount> createState() => _AccountState();
}

class _AccountState extends State<PAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1C1C55), // Set background color to #1c1c55
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C55), // Match app bar color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Profile Image
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://tse4.mm.bing.net/th?id=OIP.YgN6-oQ4KzYkxJScaAZ4jgHaHa&pid=Api&P=0&h=180', // Replace with actual image URL
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Profile Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${parentprofileData['guardianname'] ?? 'no data'}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                        Text(
                          "${parentprofileData['phoneno'] ?? 'no data'}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                        if(parentprofileData['students']!=null)
                        Text(
                          "${parentprofileData['students'][0]['email'] ?? 'no data'}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Options: About, Logout
            Column(
              children: [
                ListTile(
                  onTap: () {
                    _showAboutDialog(context);
                  },
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: const Text("About"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    _showConfirmationDialog(context, "Logout", "Are you sure you want to logout?");
                  },
                  leading: const Icon(Icons.logout, color: Colors.blue),
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Confirmation Dialog
  void _showConfirmationDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (title == "Logout") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ploginpage()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You have been logged out.")),
                );
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  // About Dialog
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("About"),
        content: const Text(
          "This is the teacher profile page. You can view your details or logout from here.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
