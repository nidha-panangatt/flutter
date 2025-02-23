import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/Ploginpage.dart';
import 'package:smart_tracking/services/teacher/teacherprofileapi.dart';

class TAccount extends StatefulWidget {
  const TAccount({super.key});

  @override
  State<TAccount> createState() => _AccountState();
}

class _AccountState extends State<TAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color(0xFF1C1C55), // Set background color to #1c1c55
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
                      'https://via.placeholder.com/150', // Replace with actual image URL
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Profile Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacherprofileData['Name'] ??
                              "no name", // Replace with actual teacher's name
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          teacherprofileData['department'] ??
                              "no val", // Replace with teacher's department
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white, // White text color
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          teacherprofileData['teacherid']
                              .toString(), // Replace with teacher's ID
                          style: const TextStyle(
                            fontSize: 16,
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
            // Options: About, Deactivate, Logout
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
                // const Divider(),
                // ListTile(
                //   onTap: () {
                //     _showConfirmationDialog(context, "Deactivate Account",
                //         "Are you sure you want to deactivate your account?");
                //   },
                //   leading: const Icon(Icons.delete, color: Colors.red),
                //   title: const Text("Deactivate My Account"),
                //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                // ),
                const Divider(),
                ListTile(
                  onTap: () {
                    _showConfirmationDialog(
                        context, "Logout", "Are you sure you want to logout?");
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
  void _showConfirmationDialog(
      BuildContext context, String title, String message) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ploginpage(),
                    ));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You have been logged out.")),
                );
              // } else if (title == "Deactivate Account") {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //         content: Text("Account has been deactivated.")),
              //   );
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
                "This is the teacher profile page. You can view your details, deactivate your account, or logout from here.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ));
  }
}
