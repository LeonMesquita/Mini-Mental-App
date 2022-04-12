import 'package:flutter/material.dart';

class gerarImagens extends StatelessWidget {
  final String imageName;
  final double imageHeight;
  final double imageWidth;
  final double avaliableArea;
  const gerarImagens({
    Key? key,
    required this.imageName,
    required this.imageHeight,
    required this.imageWidth,
    this.avaliableArea = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = ((size.height - appbar.preferredSize.height) -
            MediaQuery.of(context).padding.top) *
        avaliableArea;

    var width = size.width * imageWidth;
    var height = screenHeight * imageHeight;
    return Image(
      image: AssetImage(imageName),
      height: height,
      width: width,
    );
  }
}

//MediaQuery.of(context!).size.height * .02;