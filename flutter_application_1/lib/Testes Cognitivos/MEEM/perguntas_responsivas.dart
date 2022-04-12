import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';

class PerguntasResponsivas extends StatefulWidget {
  final String textoDaPergunta;
  final double textSize;
  final bool isResult;
  double max_height;
  PerguntasResponsivas(
      {Key? key,
      required this.textoDaPergunta,
      required this.textSize,
      this.isResult = false,
      this.max_height = 30})
      : super(key: key);

  @override
  State<PerguntasResponsivas> createState() => _PerguntasResponsivasState();
}

class _PerguntasResponsivasState extends State<PerguntasResponsivas> {
  double _maxValue({required double value, required double max}) {
    if (value < max) {
      return value;
    } else
      return max;
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var avaliableArea = ((size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top);

    var containerSize = avaliableArea * .4;
    return Text(
      widget.textoDaPergunta,
      style: TextStyle(
          fontSize: _maxValue(
              value: containerSize * widget.textSize, max: widget.max_height),
          //fontSize: containerSize * widget.textSize,
          fontWeight: FontWeight.w900,
          color: widget.isResult == false ? Colors.white : Colors.black),
      textAlign: TextAlign.center,
    );
  }
}
