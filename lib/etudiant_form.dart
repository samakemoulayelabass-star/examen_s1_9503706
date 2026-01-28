import 'package:flutter/material.dart';
import 'etudiant.dart';

class EtudiantForm extends StatefulWidget {
  const EtudiantForm({super.key});

  @override
  State<EtudiantForm> createState() => _EtudiantFormState();
}

class _EtudiantFormState extends State<EtudiantForm> {
  final numero = TextEditingController();
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final classe = TextEditingController();
  final note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter étudiant")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: numero, decoration: const InputDecoration(labelText: "Numéro")),
            TextField(controller: nom, decoration: const InputDecoration(labelText: "Nom")),
            TextField(controller: prenom, decoration: const InputDecoration(labelText: "Prénom")),
            TextField(controller: classe, decoration: const InputDecoration(labelText: "Classe")),
            TextField(controller: note, decoration: const InputDecoration(labelText: "Note")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Etudiant(
                    numero.text,
                    nom.text,
                    prenom.text,
                    classe.text,
                    double.parse(note.text),
                  ),
                );
              },
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
