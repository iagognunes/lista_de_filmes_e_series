import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:lista_de_filmes_e_series/components/fire_auth.dart';
import 'package:lista_de_filmes_e_series/components/popup_login.dart';
import 'package:lista_de_filmes_e_series/components/size_screen.dart';
import 'package:lista_de_filmes_e_series/components/validator.dart';
import 'package:lista_de_filmes_e_series/controller/controller_user.dart';
import 'package:lista_de_filmes_e_series/view/menu/view/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  UserController userController = getx.Get.put(UserController());

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userController.updateUserName(user.displayName);
      getx.Get.off(() => const Menu());
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Card(
                    elevation: 6,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: displaySize(context).width * 0.85,
                        height: displaySize(context).height * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Lista de filmes/series\nde\nIagu & Jovanna',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 46, top: 20),
                                    child: Text(
                                      'E-mail',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 6, left: 30),
                                    child: SizedBox(
                                      width: displaySize(context).width * 0.7,
                                      child: TextFormField(
                                        controller: _emailTextController,
                                        focusNode: _focusEmail,
                                        validator: (value) =>
                                            Validator.validateEmail(
                                          email: value,
                                        ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF000000)),
                                          ),
                                        ),
                                        onEditingComplete: () {},
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 46, top: 10),
                                    child: Text(
                                      'Senha',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 6, left: 30),
                                    child: SizedBox(
                                      width: displaySize(context).width * 0.7,
                                      child: TextFormField(
                                        controller: _passwordTextController,
                                        focusNode: _focusPassword,
                                        obscureText: true,
                                        validator: (value) =>
                                            Validator.validatePassword(
                                          password: value,
                                        ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF000000)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            // getx.Get.to(const RegisterPage());
                                            if (_emailTextController.text ==
                                                '') {
                                              loginPopup(
                                                  'Insira primeiro o seu email na área de login.',
                                                  true);
                                            } else {
                                              FireAuth.resetPassword(
                                                  _emailTextController.text);
                                              loginPopup(
                                                  'Um link foi enviado ao seu\n e-mail cadastrado para redefinir a senha.',
                                                  false);
                                            }
                                          },
                                          child: const Text(
                                            'Esqueci a senha',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF007BDB),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: _isProcessing
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Container(
                                                  width: 121,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF262120),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF262120),
                                                    ),
                                                  ),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                    ),
                                                    onPressed: () async {
                                                      _focusEmail.unfocus();
                                                      _focusPassword.unfocus();

                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          _isProcessing = true;
                                                        });

                                                        User? user = await FireAuth
                                                            .signInUsingEmailPassword(
                                                          email:
                                                              _emailTextController
                                                                  .text,
                                                          password:
                                                              _passwordTextController
                                                                  .text,
                                                        );

                                                        setState(() {
                                                          _isProcessing = false;
                                                        });

                                                        if (user != null) {
                                                          userController
                                                              .updateUserName(user
                                                                  .displayName);

                                                          getx.Get.off(() =>
                                                              const Menu());
                                                        }
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Entrar',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
