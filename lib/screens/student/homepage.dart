import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/PARENTS/pprofile.dart';
import 'package:smart_tracking/screens/student/gate.dart';
import 'package:smart_tracking/screens/student/lab.dart';
import 'package:smart_tracking/screens/student/transportation.dart';

import 'package:smart_tracking/services/loginapi.dart';
import 'package:smart_tracking/services/student/getgateapi.dart';
import 'package:smart_tracking/services/student/getlabapi.dart';
import 'package:smart_tracking/services/student/getlocationapi.dart';
import 'package:smart_tracking/services/student/studentprofileapi.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage> {
Map<String, dynamic> attendanceData = {};
  Future<void> fetchAttendanceData() async {
    try {
      var response = await Dio().get('$baseurl/viewattendance/$lid');
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          // Process and store attendance data
          attendanceData = response.data;
        });
      } else {
        // Handle error
        print('Failed to load attendance data');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch()async{
 await   fetchAttendanceData();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 151, 199, 237),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // AppBar background
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            // Body Content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      // Location Section
                      Card(
                        elevation: 4,
                        child: ListTile(
                          trailing: const Icon(Icons.location_on),
                          title: const Text('Location'),
                          // leading: const CircleAvatar(),
                          onTap: () async {
                          Map<String, dynamic> locationData =
                                await getlocationAPI();
                            await launchUrl(Uri.parse(
                                'https://www.google.com/maps?q=${locationData['latitude']},${locationData['longitude']}'));
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Attendance Section
                      const Text(
                        "Today's Attendance",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

    





Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: attendanceData.entries.map((entry) {
    String categoryName = entry.key.replaceAll("_", " ").toUpperCase(); // Convert to readable format
    List<Map<String, dynamic>> records = entry.value.cast<Map<String, dynamic>>(); // Ensure type safety

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              categoryName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Horizontal List of Attendance Status
          SizedBox(
            height: 50, // Ensuring proper height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: records.length,
              itemBuilder: (context, index) {
                String status = records[index]['status'] ?? 'NO';
                
                // Assign colors based on status
                Color statusColor;
                if (status.toLowerCase() == 'in') {
                  statusColor = Colors.green;
                } else if (status.toLowerCase() == 'out') {
                  statusColor = Colors.red;
                } else {
                  statusColor = Colors.grey; // Default for unknown status
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: statusColor,
                    child: Text(
                      '${records[index]['entrytime']}'.toString().substring( 11,16),
                      style: const TextStyle(color: Colors.white,fontSize: 12 ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }).toList(),
)



                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Student Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              title: 'Transportation',
                              color: Colors.pink,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TransportationScreen(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              title: 'GATE',
                              color: Colors.pink,
                              onPressed: () async {
                                List<Map<String, dynamic>> labData =
                                    await getgateAPI(lid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GateScreen(labdata: labData),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              title: 'LAB',
                              color: Colors.pink,
                              onPressed: () async {
                                List<Map<String, dynamic>> labData =
                                    await getlabAPI();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LabScreen(labdata: labData),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Profile Section (Now Clickable)
            Positioned(
              top: 15,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            '$imageurl${studentprofileData['student_image']}',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentprofileData['Name'] ?? 'No name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              studentprofileData['department'] ?? 'Not available',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Admission No: ${studentprofileData['admissionno']}" ?? 'no register no',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.title, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
