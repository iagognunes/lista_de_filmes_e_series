import 'package:flutter/material.dart';
import 'package:lista_de_filmes_e_series/components/popup_delete.dart';

Widget filmesContainer(filmes, String movieKey) {
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
                PopUpDelete(type: 'Filme', masterKey: movieKey).showPopup();
              },
            ),
          ],
        ),
      ),
    ),
  );
}
