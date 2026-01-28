import 'package:flutter/material.dart';
import 'login_page.dart';

class Lowder extends StatefulWidget {
  const Lowder({super.key});

  @override
  State<Lowder> createState() => _LowderState();
}

class _LowderState extends State<Lowder> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
