import 'package:flutter/material.dart';

class TextoResponsivo extends StatefulWidget {
  String texto;
  double total_area;
  double percent_area;
  double max_height;
  Color text_color;

  TextoResponsivo(
      {required this.texto,
      required this.total_area,
      required this.percent_area,
      this.max_height = 30,
      this.text_color = Colors.black});

  @override
  _TextoResponsivoState createState() => _TextoResponsivoState();
}

class _TextoResponsivoState extends State<TextoResponsivo> {
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
            MediaQuery.of(context).padding.top) *
        widget.total_area;

    // var containerSize = avaliableArea * .4;
    return Text(
      widget.texto,
      style: TextStyle(
          fontSize: _maxValue(
            value: avaliableArea * widget.percent_area,
            max: widget.max_height,
          ),
          fontWeight: FontWeight.bold,
          color: widget.text_color),
      textAlign: TextAlign.start,
    );
  }
}
