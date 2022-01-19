import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpDelete {
  final String type, masterKey;

  PopUpDelete({required this.type, required this.masterKey});

  Future showPopup() {
    DatabaseReference _ref = FirebaseDatabase.instance.ref().child(type);

    return Get.defaultDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      content: SizedBox(
        height: 150,
        width: 327,
        child: Center(
          child: Text(
            'DESEJA EXCLUIR O(A) $type?',
            style: const TextStyle(
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
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () async {
              _ref.child(masterKey).remove().whenComplete(() => Get.back());
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
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
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
  }
}
