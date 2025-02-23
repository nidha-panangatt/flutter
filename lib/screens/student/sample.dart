import 'package:flutter/material.dart';

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // AppBar background
          Container(
            height: 80, // Height of the AppBar background
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          // Body Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120), // Leave space for the profile section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for other content
                      const SizedBox(
                        height: 100,
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          height: 150,
                          color: Colors.amber,
                          child:
                              const Center(child: Text("Carousel or Banner Section")),
                        ),
                      ),
                      const SizedBox(height: 16),
                    Container(
          height: 250,
          width: 350,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('student details'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: TextButton(
                        onPressed: () {}, child: const Text('Lab Attendance')),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: TextButton(onPressed: () {}, child: const Text('dfghjk')),
                  )
                ],
              )
            ],
          ),
        ),
                      const SizedBox(height: 16),
                      const Text(
                        "Today's Attendance",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return CircleAvatar(
                            radius: 20,
                            child: Text("${index + 1} hr"),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Profile Section
          Positioned(
            top: 15, // Adjust the vertical position of the card
            left: 16,
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Replace with the actual image URL
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FATHIMA NIDHA P",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "BSc Computer Science - 2022-25",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Register No: UTAWCS026",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Admission No: 8962",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
    );
  }
}