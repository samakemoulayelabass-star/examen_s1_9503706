import 'package:flutter/material.dart';
import 'etudiant.dart';
import 'etudiant_form.dart';

class EtudiantList extends StatefulWidget {
  const EtudiantList({super.key});

  @override
  State<EtudiantList> createState() => _EtudiantListState();
}

class _EtudiantListState extends State<EtudiantList> {

  // ✅ 20 étudiants déjà ajoutés
  List<Etudiant> etudiants = [
    Etudiant("ML001", "Traore", "Moussa", "3II", 14),
    Etudiant("ML002", "Keita", "Aminata", "3II", 9),
    Etudiant("ML003", "Diallo", "Oumar", "2II", 11),
    Etudiant("ML004", "Coulibaly", "Fatou", "2II", 16),
    Etudiant("ML005", "Samake", "Ibrahim", "4ISRT", 8),
    Etudiant("ML006", "Sissoko", "Mariame", "4ISRT", 12),
    Etudiant("ML007", "Camara", "Sekou", "2ISR", 7),
    Etudiant("ML008", "Diarra", "Awa", "2ISR", 15),
    Etudiant("ML009", "Maiga", "Abdoulaye", "1GLT", 10),
    Etudiant("ML010", "Konate", "Salimata", "1GLT", 13),
    Etudiant("ML011", "Fofana", "Boubacar", "1GRH", 6),
    Etudiant("ML012", "Sangare", "Kadidia", "1GRH", 17),
    Etudiant("ML013", "Toure", "Mohamed", "1CPA", 11),
    Etudiant("ML014", "Cisse", "Hawa", "1CPA", 18),
    Etudiant("ML015", "Kone", "Adama", "1CPB", 9),
    Etudiant("ML016", "Bagayoko", "Mariam", "1CPB", 14),
    Etudiant("ML017", "Doumbia", "Yacouba", "3II", 5),
    Etudiant("ML018", "Sidibe", "Aissata", "3II", 16),
    Etudiant("ML019", "Dembélé", "Issa", "2II", 12),
    Etudiant("ML020", "Ouattara", "Nene", "2II", 19),
  ];

  final searchController = TextEditingController();
  List<Etudiant> resultatRecherche = [];

  // ====== CALCULS OBLIGATOIRES ======

  double moyenne() {
    double somme = 0;
    for (var e in etudiants) {
      somme += e.note;
    }
    return etudiants.isEmpty ? 0 : somme / etudiants.length;
  }

  double meilleureNote() {
    double max = etudiants[0].note;
    for (var e in etudiants) {
      if (e.note > max) max = e.note;
    }
    return max;
  }

  double plusFaibleNote() {
    double min = etudiants[0].note;
    for (var e in etudiants) {
      if (e.note < min) min = e.note;
    }
    return min;
  }

  int admis() {
    int c = 0;
    for (var e in etudiants) {
      if (e.note >= 10) c++;
    }
    return c;
  }

  int ajournes() {
    int c = 0;
    for (var e in etudiants) {
      if (e.note < 10) c++;
    }
    return c;
  }

  void rechercherEtudiant() {
    resultatRecherche.clear();
    for (var e in etudiants) {
      if (e.nom.toLowerCase() == searchController.text.toLowerCase() ||
          e.numero == searchController.text) {
        resultatRecherche.add(e);
      }
    }
    setState(() {});
  }

  // ====== UI ======

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des étudiants")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final e = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EtudiantForm()),
          );
          if (e != null) {
            setState(() {
              etudiants.add(e);
              resultatRecherche.clear();
            });
          }
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Text("Moyenne générale : ${moyenne().toStringAsFixed(2)}"),
          Text("Meilleure note : ${meilleureNote()}"),
          Text("Plus faible note : ${plusFaibleNote()}"),
          Text("Admis : ${admis()}"),
          Text("Ajournés : ${ajournes()}"),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Recherche (nom ou numéro)",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: rechercherEtudiant,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: resultatRecherche.isEmpty
                  ? etudiants.length
                  : resultatRecherche.length,
              itemBuilder: (context, i) {
                final e = resultatRecherche.isEmpty
                    ? etudiants[i]
                    : resultatRecherche[i];

                return Card(
                  child: ListTile(
                    title: Text("${e.nom} ${e.prenom}"),
                    subtitle: Text(
                      "Numéro : ${e.numero} | Classe : ${e.classe} | "
                      "Note : ${e.note} | "
                      "${e.note >= 10 ? "ADMIS" : "AJOURNÉ"}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          etudiants.remove(e);
                          resultatRecherche.clear();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
