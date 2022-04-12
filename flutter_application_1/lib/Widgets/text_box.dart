import 'package:flutter/material.dart';

import 'constantes.dart';

Widget textBox(
    {required String label,
    required TextEditingController controlador,
    required double altura,
    required double labelSize,
    required double cursorSize,
    bool isNumber = false,
    bool centerLabel = false,
    required GlobalKey<FormState> validador}) {
  return Form(
    key: validador,
    child: Container(
      height: altura,
      child: TextFormField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          cursorHeight: cursorSize,
          cursorColor: kCorDoTema,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: labelSize,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kCorDoTema, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          controller: controlador,
          textAlign: centerLabel == true ? TextAlign.center : TextAlign.start,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Você deve preencher este campo!';
            }
          }),
    ),
  );
}
