import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_tracking/services/teacher/teacherprofileapi.dart';

class LabAttendanceScreen extends StatefulWidget {
  const LabAttendanceScreen({super.key, this.labdata});
  final labdata;
  @override
  _LabAttendanceScreenState createState() => _LabAttendanceScreenState();
}

class _LabAttendanceScreenState extends State<LabAttendanceScreen> {
  String? selectedDepartment;
  String? selectedSemester;
  DateTime? fromDate;
  DateTime? toDate;

  final List<String> departments = [
    'Computer Science',
    'Botany',
    'Chemistry',
    'Home Science'
  ];
  final List<String> semesters = ['1', '2', '3', '4', '5', '6'];

  // Helper function to format dates
  String formatDate(DateTime? date) {
    return date != null
        ? DateFormat('dd-MM-yyyy').format(date)
        : ''; // Blank if no date is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Attendance',
          style: TextStyle(
            color: Colors.white, // Set font color to white
          ),
        ),
        backgroundColor:
            const Color(0xFF1C1C55), // Set background color to #1c1c55
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set icon color to white
          onPressed: () {
            Navigator.pop(context);
            // Navigate back
          },
        ),
        actions: [
          // Profile Section on the rightmost side
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                      'assets/profile.jpg'), // Use your profile image here
                ),
                const SizedBox(width: 8),
                // Profile Info (Name and ID)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      teacherprofileData['Name']
                          .toString(), // Replace with dynamic name
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID:${teacherprofileData['teacherid'].toString()}', // Replace with dynamic ID
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar and Filter Button Row
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _showCustomDateFilterDialog(),
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1C1C55),
                    backgroundColor:
                        Colors.white, // Set text and icon color to dark blue
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius to 10
                    ),
                    side: const BorderSide(
                        color: Color(0xFF1C1C55), width: 1), // Border color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dropdowns for Department and Semester
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Department',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedDepartment,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                    },
                    items: departments
                        .map((dept) =>
                            DropdownMenuItem(value: dept, child: Text(dept)))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Semester',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedSemester,
                    onChanged: (value) {
                      setState(() {
                        selectedSemester = value;
                      });
                    },
                    items: semesters
                        .map((sem) =>
                            DropdownMenuItem(value: sem, child: Text(sem)))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
                child: ListView.builder(
              itemCount: widget.labdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Date: ${widget.labdata[index]['entrytime']
                        .toString()
                        .substring(0, 10)}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Entry: ${widget.labdata[index]['entrytime']
                            .toString()
                            .substring(11, 19)}'),
                        Text('Exit: ${widget.labdata[index]['exittime']
                            .toString()
                            .substring(11, 19)}'),
                        Text(
                            'Period: ${widget.labdata[index]['period'].toString()}'),
                        Text('Lab: ${widget.labdata[index]['LAB'].toString()}'),
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _showCustomDateFilterDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Custom Date Filter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("From"),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: fromDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                fromDate = pickedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today, size: 16),
                          label: Text(fromDate == null
                              ? "Select"
                              : formatDate(fromDate)),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF1C1C55),
                            backgroundColor: Colors
                                .white, // Set text and icon color to dark blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius to 10
                            ),
                            side: const BorderSide(
                                color: Color(0xFF1C1C55),
                                width: 1), // Border color
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("To"),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: toDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                toDate = pickedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today, size: 16),
                          label: Text(
                              toDate == null ? "Select" : formatDate(toDate)),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF1C1C55),
                            backgroundColor: Colors
                                .white, // Set text and icon color to dark blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius to 10
                            ),
                            side: const BorderSide(
                                color: Color(0xFF1C1C55),
                                width: 1), // Border color
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (fromDate != null && toDate != null) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Filtered from ${formatDate(fromDate)} to ${formatDate(toDate)}",
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
