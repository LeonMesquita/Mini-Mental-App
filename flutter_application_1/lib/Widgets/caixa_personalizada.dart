import 'package:flutter/material.dart';

class CaixaPersonalizada extends StatelessWidget {
  CaixaPersonalizada(
      {this.largura,
      this.altura,
      this.cor,
      this.filhoCaixa,
      this.margem = 0,
      this.bordaCircular = 0,
      this.aoInteragir,
      this.sombraCor = Colors.transparent});

  final double? largura;
  final double? altura;
  final Color? cor;
  final Color sombraCor;
  final Widget? filhoCaixa;
  final double margem;
  final double bordaCircular;
  final Function()? aoInteragir;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: aoInteragir,
        child: Container(
          margin: EdgeInsets.all(margem),
          width: largura,
          height: altura,
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(bordaCircular),
            boxShadow: [
              BoxShadow(
                color: sombraCor,
                spreadRadius: 0.3,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: filhoCaixa,
        ),
      ),
    );
  }
}
