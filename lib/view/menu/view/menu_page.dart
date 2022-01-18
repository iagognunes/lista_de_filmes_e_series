import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/components/size_screen.dart';
import 'package:lista_de_filmes_e_series/controller/controller_user.dart';
import 'package:lista_de_filmes_e_series/view/add_movie_serie/view/add_movie_serie.dart';
import 'package:lista_de_filmes_e_series/view/filmes/view/filmes_view.dart';
import 'package:lista_de_filmes_e_series/view/login/view/login_page.dart';
import 'package:lista_de_filmes_e_series/view/series/view/series_view.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Obx(
          () => Text(
            "Bem vindo/a, ${userController.user.value.name}",
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        actions: [
          _isSigningOut
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () async {
                    Get.defaultDialog(
                      backgroundColor: const Color(0xFFFFFFFF),
                      content: const SizedBox(
                        height: 150,
                        width: 327,
                        child: Center(
                          child: Text(
                            'DESEJA SAIR DA CONTA?',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFF262120),
                            ),
                          ),
                        ),
                      ),
                      radius: 1,
                      title: '',
                      confirm: Padding(
                        padding: const EdgeInsets.only(bottom: 57, left: 24),
                        child: Container(
                          height: 56,
                          width: 124,
                          color: const Color(0xFF262120),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isSigningOut = true;
                              });

                              await FirebaseAuth.instance.signOut();

                              setState(() {
                                _isSigningOut = false;
                              });

                              Get.off(() => const LoginPage());
                            },
                            child: const Text(
                              'SIM',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      cancel: Container(
                        height: 56,
                        width: 124,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: const Color(0xFF262120),
                            width: 2,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'NÃO',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF262120),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.deepPurpleAccent,
        icon: Icons.add,
        overlayOpacity: 0.2,
        spaceBetweenChildren: 15,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.arrow_back_ios_rounded),
            label: 'Série',
            onTap: () => Get.to(() => const AddMovieSerie(typeInsert: 'Série')),
          ),
          SpeedDialChild(
            child: const Icon(Icons.arrow_back_ios_rounded),
            label: 'Filme',
            onTap: () => Get.to(() => const AddMovieSerie(typeInsert: 'Filme')),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: displaySize(context).height,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/amor.jpg',
                      height: 250,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          color: const Color(0xFF262120),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          onPressed: () => Get.to(() => const FilmesView()),
                          child: const Text(
                            'Filmes',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          color: const Color(0xFF262120),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          onPressed: () => Get.to(() => const SeriesView()),
                          child: const Text(
                            'Séries',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
