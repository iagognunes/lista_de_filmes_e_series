import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/components/popup_login.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../components/notifications.dart';

class AddMovieSerie extends StatefulWidget {
  final String typeInsert;
  const AddMovieSerie({Key? key, required this.typeInsert}) : super(key: key);

  @override
  _AddMovieSerieState createState() => _AddMovieSerieState();
}

class _AddMovieSerieState extends State<AddMovieSerie> {
  final _addKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _typeTextController = TextEditingController();
  final _sinopseTextController = TextEditingController();
  final _ratingTextController = TextEditingController();
  final _whereWatchTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusType = FocusNode();
  final _focusSinopse = FocusNode();
  final _focusRating = FocusNode();
  final _focusWhere = FocusNode();

  late DatabaseReference _ref;

  @override
  void initState() {
    _ref = FirebaseDatabase.instance.ref().child(widget.typeInsert);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusType.unfocus();
        _focusSinopse.unfocus();
        _focusRating.unfocus();
        _focusWhere.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar ' + widget.typeInsert),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _addKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _nameTextController,
                    focusNode: _focusName,
                    decoration: InputDecoration(
                      hintText: "Nome",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _typeTextController,
                      focusNode: _focusType,
                      decoration: InputDecoration(
                        hintText: "Gênero",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: TextFormField(
                  //     controller: _sinopseTextController,
                  //     focusNode: _focusSinopse,
                  //     decoration: InputDecoration(
                  //       hintText: "Sinopse",
                  //       errorBorder: UnderlineInputBorder(
                  //         borderRadius: BorderRadius.circular(6.0),
                  //         borderSide: const BorderSide(
                  //           color: Colors.red,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _ratingTextController,
                      focusNode: _focusRating,
                      decoration: InputDecoration(
                        hintText: "Nota do IMDB",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _whereWatchTextController,
                      focusNode: _focusWhere,
                      decoration: InputDecoration(
                        hintText: "Onde assistir",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              NotificationService().showLocalNotification(
                                CustomNotification(
                                  id: 0,
                                  title: 'App Filmes & Séries',
                                  body: 'Foi adicionado(a) um(a) novo(a) ${widget.typeInsert}.',
                                  payload: widget.typeInsert,
                                ),
                              );
                              registerMoviewSerie();
                            },
                            child: const Text(
                              'Adicionar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerMoviewSerie() {
    String name = _nameTextController.text;
    String gender = _typeTextController.text;
    String sinopse = _sinopseTextController.text;
    String rating = _ratingTextController.text;
    String whereWatch = _whereWatchTextController.text;

    Map<String, Object> movieSerie = {
      'name': name,
      'gender': gender,
      'rating': rating,
      'whereWatch': whereWatch,
      'sinopse': sinopse
    };

    if (_isInputEmpty()) {
      loginPopup('Digite todas as informações!', true);
    } else {
      debugPrint(_ref.key);
      OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: ['b3giabc2-9a47-4647-adda-3e4583a2d19e'],
        heading: 'teste sendcode',
        content: 'teste',
      ));
      _ref.push().set(movieSerie).then((value) => Get.back());
    }
  }

  bool _isInputEmpty() {
    if (_nameTextController.text == "" ||
        _typeTextController.text == "" ||
        _ratingTextController.text == "" ||
        _whereWatchTextController.text == "") {
      return true;
    } else {
      return false;
    }
  }
}
