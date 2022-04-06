import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/view/login/view/login_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setExternalUserId("945de9bd-592a-42da-bb94-50103e6f9115");

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      debugPrint("Accepted permission: $accepted");
    });

    OneSignal.shared.setExternalUserId('b3giabc2-9a47-4647-adda-3e4583a2d19e');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Séries/Filmes',
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
