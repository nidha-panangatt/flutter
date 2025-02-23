import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/student/snotification.dart';
import 'package:smart_tracking/screens/teacher/Taccount.dart';
import 'package:smart_tracking/screens/teacher/Tgate.dart';
import 'package:smart_tracking/screens/teacher/labattendance.dart';
import 'package:smart_tracking/services/teacher/getgateapi.dart';
import 'package:smart_tracking/services/teacher/getlabattendanceapi.dart';
import 'package:smart_tracking/services/teacher/teacherprofileapi.dart';


class THomepage extends StatefulWidget {
  const THomepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<THomepage> {
  int _selectedIndex = 0; // Keeps track of the selected index

  // List of screens corresponding to the BottomNavigationBar items
  final List<Widget> _screens = [
    const HomeScreen(),           // Home screen
    const NotificationScreen(),  // Notifications screen
    const TAccount(),             // Account screen
  ];

  // Function to handle BottomNavigationBar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C55), // Blue background color
      body: _screens[_selectedIndex], // Display screen based on selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Color(0xFF1C1C55)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            activeIcon: Icon(Icons.notifications, color: Color(0xFF1C1C55)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            activeIcon: Icon(Icons.account_circle, color: Color(0xFF1C1C55)),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C55),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Teacher Profile Section
              Container(
                width: screenWidth-40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 15),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacherprofileData['Name']??'no name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Department: ${ teacherprofileData['department']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "ID: ${teacherprofileData['teacherid']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              // Add a SizedBox with height equal to 7cm (264.565px) to move the student details down
              const SizedBox(height: 50), // Space of 7cm
          
              // Student Details Section with white background and black text
              Container(
                width: screenWidth-40,
                height: 200,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,  // White background color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      // child: Text(
                      //   "Student Details",
                      //   style: TextStyle(
                      //     color: Colors.black, // Black text color
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lab Button (replacing Transportation)
                        Expanded(
                          child: GestureDetector(
                            onTap: ()async {
                                              List<Map<String, dynamic>>labdata=     await teachergetlabattendanceAPI();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  LabAttendanceScreen(labdata:labdata), // Replace with the correct page for Lab
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                             
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C55),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Lab", //  "Lab"
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: ()async {
                                               List<Map<String, dynamic>>gatedata=      await teachergetgateAPI();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  TGateScreen(gatedata:gatedata),
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                             
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1C55),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Gate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}