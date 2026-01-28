import 'package:flutter/material.dart';
import 'etudiant_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final login = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: login, decoration: const InputDecoration(labelText: "Login")),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Mot de passe")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (login.text == "3ii" && password.text == "moulaye") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const EtudiantList()),
                  );
                }
              },
              child: const Text("Connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
