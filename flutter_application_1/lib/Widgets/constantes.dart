/* Criar aqui os widgets de texto, icones e etc para reutilizar
em qualquer parte do código. isso evita a repetição de código.
*/

import 'package:flutter/material.dart';

const kLoginTextStyle = TextStyle(
    fontSize: 40, color: Color(0xFF842382), fontWeight: FontWeight.bold);

const kTextoPadraoStyle = TextStyle(fontSize: 12, color: Colors.black);

const kHintTextStyle = TextStyle(
  textBaseline: TextBaseline.ideographic,
  fontSize: 11,
  color: Colors.black54,
  fontStyle: FontStyle.italic,
);

enum TipoDeTexto {
  email,
  password,
}

const kBoxTextShadow = BoxShadow(color: Colors.black, spreadRadius: 0.5);

var kCorBotaoDeTexto = Colors.blue.shade800;
const kCorDoBotao = Color(0xFF842382);

// Tamanho do padding dos widgets na tela
const kMargemDosWidgets = 10.0;

const kCaixaCor = Colors.white;

const kTamanhoDaCaixa = 150.0;

const kTextoDosBotoesDaTelaInicial =
    TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

// Constantes em relação ao tema e a barra
const kTextoDaBarra =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
var kCorDoTema = Color(0xFF842382); //Colors.purple;

const kCorGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFF842382),
    Color(0xFF872ad3),
    Color(0xFFae5fce),
  ],
);

const kCorInativaGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFF8c8888),
    Color(0xFF999191),
    Color(0xFF7f7979),
  ],
);

const kCorAtiva = Color(0xFF35f23e);
//6ff776  0ef71a
const kCorInativa = Colors.white;
//.........................................................
var kSombraCor = Colors.grey;

const kTelaDeCadastroTexto =
    TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

const kTelaDeCadastroTextoPadrao =
    TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold);

const kTelaDeCadastroTextoOpcao = TextStyle(fontSize: 12);

const kSizedBox50 = 40.0;

// constantes referentes ao MEEM
const kEstiloDasPerguntas =
    TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800, color: Colors.white);

//
// cores do exame

const kCorOrientacaoTemporal = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFFc072c1),
    Color(0xFFc246c4),
    Color(0xFFc101c4),
  ],
);
//
//
const kCorOrientacaoEspacial = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFFa96daa),
    Color(0xFF922d93),
    Color(0xFF69026b),
  ],
);
//
//
const kCorMemoriaImediata = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFFb153cc),
    Color(0xFF82289b),
    Color(0xFF5c0177),
  ],
);
//
//
const kCorCalculo = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFFbd86f4),
    Color(0xFF983ef2),
    Color(0xFF7a04ef),
  ],
);
//
//
const kCorMemoriaRecente = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFF8f5fb7),
    Color(0xFF7e38b7),
    Color(0xFF6e16b7),
  ],
);
//
//
const kCorLinguagem = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  //stops: [0.2, 0.4, 0.3],
  colors: [
    Color(0xFF9b71c4),
    Color(0xFF5431a0),
    Color(0xFF3a0d9b),
  ],
);

//
//
const kBackgroundImage = 'assets/imagens/design/Background.jpg';

const kLogoImage = 'assets/imagens/design/logo.png';

const kBack = 'assets/imagens/actions/home.png';

const kPurpleColor = Color(0xFF5692ce6);
