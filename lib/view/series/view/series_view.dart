import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/components/size_screen.dart';
import 'package:lista_de_filmes_e_series/view/add_movie_serie/view/add_movie_serie.dart';
import 'package:lista_de_filmes_e_series/view/series/components/series_container.dart';

class SeriesView extends StatefulWidget {
  const SeriesView({Key? key}) : super(key: key);

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('Séries para ver'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => Get.to(() => const AddMovieSerie(typeInsert: 'Série')),
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
                      .child('Série')
                      .orderByChild('rating'),
                  duration: const Duration(seconds: 2),
                  itemBuilder: (
                    BuildContext context,
                    DataSnapshot snapshot,
                    Animation<double> animation,
                    int index,
                  ) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0))
                          .animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.bounceOut,
                              reverseCurve: Curves.bounceIn)),
                      child: seriesContainer(
                          snapshot.value, snapshot.key.toString()),
                    );
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
