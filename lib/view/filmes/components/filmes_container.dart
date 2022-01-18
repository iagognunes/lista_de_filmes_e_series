import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Widget filmesContainer(filmes, String movieKey) {
  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('Filme');

  return Card(
    elevation: 5,
    shadowColor: Colors.deepPurple,
    child: SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Nome: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                        text: filmes['name'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Gênero: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                        text: filmes['gender'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Nota IMDB: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                        text: filmes['rating'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Onde assistir: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                        text: filmes['whereWatch'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _ref.child(movieKey).remove();
                debugPrint(movieKey);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
