import 'package:flutter/material.dart';
import 'constantes.dart';
import 'botaopadrao.dart';

class BotaoSimOuNao extends StatelessWidget {
  final Function() aoApertar;
  final String texto;
  Color cor;
  BotaoSimOuNao({
    Key? key,
    required this.aoApertar,
    required this.texto,
    required this.cor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: BotaoPadrao(
        corDoBotao: cor,
        botaoTexto: texto,
        aoPressionar: () {
          aoApertar;
        },
      ),
    );
  }
}


/*
Widget botaoDeSimOuNao(
    {required Function aoApertar,
    required String texto,
    required Gradient cor}) {
  return Container(
    width: 120,
    child: BotaoPadrao(
      corDoBotao: cor,
      botaoTexto: texto,
      aoPressionar: () {
        aoApertar;
      },
    ),
  );
}*/