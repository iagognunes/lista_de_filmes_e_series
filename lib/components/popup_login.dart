import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future loginPopup(String textError, bool isError) {
  return Get.defaultDialog(
    title: '',
    radius: 1,
    middleText: textError,
    middleTextStyle: TextStyle(
      fontSize: 19,
      color: isError ? const Color(0xFFFF0000) : const Color(0xFF262120),
    ),
    confirm: Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 20),
      child: Container(
        height: 56,
        width: 124,
        color: const Color(0xFF262120),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'VOLTAR',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    ),
  );
}
