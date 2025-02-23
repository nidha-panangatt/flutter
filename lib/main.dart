import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/Ploginpage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
     
    home:Ploginpage(),
       //transportation(),
      //  HomeScreenPage(),
       //Account(),
      //TransportationScreen(),
      // LabScreen(),
       //GateScreen(),
      //LabAttendanceScreen(),
      //TGateScreen(),
      
      //THomepage(),
      // Ploginpage(),
        // PHomepage(),
      //PTransportation(),
      //PGateScreen(),
      //NotificationScreen(),
       //TAccount(),
      //TNotificationScreen(),
      //BottomNavBar(),
      //PAccount(),
      // PNotificationScreen(),
      //TGateScreen(),
     // PaymentPage(),
      

      

      
      debugShowCheckedModeBanner: false,
    );
  }
}

