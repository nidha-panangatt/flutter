
import 'package:flutter/material.dart';

class ert extends StatelessWidget {
  const ert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('xcvbnm'),
        centerTitle:true,
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.abc_outlined),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.access_time))
      ],
    ));

  }
}