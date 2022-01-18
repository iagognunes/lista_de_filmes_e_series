import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_filmes_e_series/components/size_screen.dart';
import 'package:lista_de_filmes_e_series/view/filmes/components/filmes_container.dart';

class FilmesView extends StatefulWidget {
  const FilmesView({Key? key}) : super(key: key);

  @override
  _FilmesViewState createState() => _FilmesViewState();
}

class _FilmesViewState extends State<FilmesView> {
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('Filmes para ver'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: displaySize(context).height,
                width: displaySize(context).width * 0.9,
                child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .ref()
                      .child('Filme')
                      .orderByChild('rating'),
                  itemBuilder: (
                    BuildContext context,
                    DataSnapshot snapshot,
                    Animation<double> animation,
                    int index,
                  ) {
                    if (snapshot.exists) {
                      return filmesContainer(
                          snapshot.value, snapshot.key.toString());
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
