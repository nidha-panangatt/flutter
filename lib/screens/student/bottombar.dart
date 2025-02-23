import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/student/homepage.dart';
import 'package:smart_tracking/screens/student/saccount.dart';
import 'package:smart_tracking/screens/student/snotification.dart';
import 'package:smart_tracking/services/student/getnotificationapi.dart';



class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  // List of screens for each BottomNavigationBar item
  final List<Widget> _screens = [
    const  HomeScreenPage(),
    const NotificationScreen(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Show the selected screen
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index)async {
            await getnotificationAPI();
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}

// BottomNavBar with onTap functionality
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // Trigger onTap to update the current index
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notification"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
      ],
    );
  }
}

// Placeholder for Home Screen


