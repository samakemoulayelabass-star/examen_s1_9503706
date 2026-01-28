import 'package:flutter/material.dart';
import 'etudiant.dart';
import 'etudiant_form.dart';

class EtudiantList extends StatefulWidget {
  const EtudiantList({super.key});

  @override
  State<EtudiantList> createState() => _EtudiantListState();
}

class _EtudiantListState extends State<EtudiantList> {
  List<Etudiant> etudiants = [];

  final searchController = TextEditingController();
  List<Etudiant> resultatRecherche = [];

  

  double moyenne() {
    double somme = 0;
    for (var e in etudiants) {
      somme += e.note;
    }
    return etudiants.isEmpty ? 0 : somme / etudiants.length;
  }

  double meilleureNote() {
    if (etudiants.isEmpty) return 0;
    double max = etudiants[0].note;
    for (var e in etudiants) {
      if (e.note > max) {
        max = e.note;
      }
    }
    return max;
  }

  double plusFaibleNote() {
    if (etudiants.isEmpty) return 0;
    double min = etudiants[0].note;
    for (var e in etudiants) {
      if (e.note < min) {
        min = e.note;
      }
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
      if (e.nom.toLowerCase() ==
              searchController.text.toLowerCase() ||
          e.numero == searchController.text) {
        resultatRecherche.add(e);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des étudiants"),
      ),

      
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

          const SizedBox(height: 10),

          
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
