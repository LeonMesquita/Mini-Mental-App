import 'package:flutter/material.dart';
import 'get_position.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Teste> {
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
        .4;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: avaliableArea,
              width: size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3)),
              child: Center(
                child: Text(
                  'fvniufvifvnfjivnfjivndfmdsjndsjvndjivnsdjivnsdjivcnsdjivdhvdhvvvsdvsdhv djsvdsjvdhvdvdhdvdvddjdsvndv',
                  style: TextStyle(
                      fontSize: _maxValue(value: size.width * .2, max: 30),
                      // fontSize: avaliableArea * .15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  size.width.toString(),
                ),
                Text(
                  size.height.toString(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
