import 'package:flutter/material.dart';
import 'package:smart_tracking/services/teacher/teacherprofileapi.dart';

class TGateScreen extends StatefulWidget {
  const TGateScreen({super.key, this.gatedata});
final gatedata;
  @override
  _TGateScreenState createState() => _TGateScreenState();
}

class _TGateScreenState extends State<TGateScreen> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gate",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1C1C55),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                      'assets/profile.jpg'), // Replace with your profile image path
                ),
                const SizedBox(width: 8),
                // Profile Info (Name and ID)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      teacherprofileData['Name'].toString(), // Replace with dynamic name
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID: ${teacherprofileData['teacherid'].toString()}', // Replace with dynamic ID
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
            const Text(
              "Recent Check-In/Out",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    _showCustomDateFilterDialog();
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text("Filter"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            Expanded(
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal, // Enables horizontal scrolling if needed
    child: DataTable(
      columns: [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Entry Time')),
        DataColumn(label: Text('Exit Time')),
      ],
      rows: widget.gatedata.map<DataRow>((data) {
        return DataRow(cells: [
          DataCell(Text(data['entrydate'].toString().substring(0, 10))),
          DataCell(
            data['entrytime'] != null
                ? Text(data['entrytime'].toString().substring(11, 19))
                : Text('-'), // Show '-' if null
          ),
          DataCell(
            data['exittime'] != null
                ? Text(data['exittime'].toString().substring(11, 19))
                : Text('-'), // Show '-' if null
          ),
        ]);
      }).toList(),
    ),
  ),
)

          ],
        ),
      ),
    );
  }

  void _showCustomDateFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(builder: (context, setState) => 
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Custom Date",
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
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: fromDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  fromDate = pickedDate;
                                  print(fromDate);
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: Text(fromDate == null
                                ? "Select"
                                : fromDate!.toLocal().toShortDateString()),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("To"),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
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
                            label: Text(toDate == null
                                ? "Select"
                                : toDate!.toLocal().toShortDateString()),
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
                                "Filtered from ${fromDate!.toLocal().toShortDateString()} to ${toDate!.toLocal().toShortDateString()}",
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
          ),
        );
      },
    );
  }
}

extension DateTimeExtensions on DateTime {
  String toShortDateString() {
    return "$day/$month/$year";
  }
}
