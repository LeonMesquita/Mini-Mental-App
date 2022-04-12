import 'dart:math';

import 'perguntas_responsivas.dart';

List<int> numerosDoCalculo = [
  100,
  110,
  120,
  130,
  140,
  150,
  160,
  170,
  180,
  190,
  200
];
int calc = 0;

int atribuirNumero() {
  calc = numerosDoCalculo[Random().nextInt(numerosDoCalculo.length)];
  return calc;
}

String enunciadoDoCalculo() {
  return 'Quanto é $calc -7?';
}

dynamic realizarCalculo() {
  int temp = calc;
  calc = calc - 7;

  return PerguntasResponsivas(
    textoDaPergunta: 'Quanto é $temp -7?',
    textSize: .15,
  );
}
