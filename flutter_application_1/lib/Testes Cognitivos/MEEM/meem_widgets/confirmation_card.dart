import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../Widgets/botaopadrao.dart';
import '../../../Widgets/constantes.dart';

class ConfirmationCard extends StatelessWidget {
  final String cartText;
  final Color buttonYesColor;
  final Color buttonNoColor;
  final void Function() onPressYes;
  final void Function() onPressNo;
  ConfirmationCard(
      {Key? key,
      required this.cartText,
      required this.buttonYesColor,
      required this.buttonNoColor,
      required this.onPressYes,
      required this.onPressNo})
      : super(key: key);

  double _maxValue({required double value, required double max}) {
    if (value < max) {
      return value;
    } else
      return max;
  }

  double alturaDoBotao = .1;
  double larguraDoBotao = .33;
  double tamanhoDoTexto = .04;

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var appbarHeight =
        appbar.preferredSize.height + MediaQuery.of(context).padding.top;
    var screenHeight = size.height - appbarHeight;
    return Container(
      height: _maxValue(value: screenHeight * .35, max: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textoDeConfirmacao(
                texto: cartText, textSize: screenHeight * tamanhoDoTexto),
            //
            //
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                height: _maxValue(value: screenHeight * alturaDoBotao, max: 65),
                width: size.width * larguraDoBotao,
                child: BotaoPadrao(
                  altura:
                      _maxValue(value: screenHeight * alturaDoBotao, max: 65),
                  corDoBotao: buttonNoColor,
                  botaoTexto: 'Não',
                  isWhite: true,
                  aoPressionar: onPressNo,
                ),
              ),
              Container(
                height: _maxValue(value: screenHeight * alturaDoBotao, max: 65),
                width: size.width * larguraDoBotao,
                child: BotaoPadrao(
                  aoPressionar: onPressYes,
                  corDoBotao: buttonYesColor,
                  botaoTexto: 'Sim',
                  isWhite: true,
                  altura:
                      _maxValue(value: screenHeight * alturaDoBotao, max: 65),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget textoDeConfirmacao({required String texto, required double textSize}) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: _maxValue(value: textSize, max: 24),
        color: kPurpleColor,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}
