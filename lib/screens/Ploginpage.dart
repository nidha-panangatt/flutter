import 'package:flutter/material.dart';
import 'package:smart_tracking/services/loginapi.dart';

class Ploginpage extends StatefulWidget {
  const Ploginpage({super.key});

  @override
  State<Ploginpage> createState() => _loginpageState();
}




class _loginpageState extends State<Ploginpage> {
  final _usernameController=TextEditingController();
  final _passwordController=TextEditingController();
  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            // Purple Rounded Rectangle (matching width only)
            Positioned(
              
              child: Container(

                height: MediaQuery.of(context).size.height,  // Height of purple container remains the same
                width: MediaQuery.of(context).size.width,   // Matching width
                decoration: const BoxDecoration(
                  color:  Color(0xFF1C1C55), // Purple color
                  // borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            // White Rounded Rectangle (overlapping purple container, showing a bit more of it)
            Positioned(
              top: 80,
              left: 5,right: 5  , // Moved further down to show more of the purple container
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:MediaQuery.of(context).size.height, // Reduced height to show more purple container
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align to start
                      children: [
                        const SizedBox(height: 40), // To avoid too much space at the top
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Username (Email) Field with the updated design
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF1C1C55),
                              width: 1.5,
                            ),
                          ),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.transparent, // Transparent to allow the container background to show
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Password Field with the updated design
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF1C1C55),
                              width: 1.5,
                            ),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.transparent, // Transparent to allow the container background to show
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                 loginApi(_usernameController.text,_passwordController.text,context);
                
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C1C55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 40,),
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