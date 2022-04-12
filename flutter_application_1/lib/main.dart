import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/pagina_de_resultados.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/teste.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/selecionar_exame.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'package:flutter_application_1/Testes Cognitivos/MEEM/meem.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/get_position.dart';
import 'package:flutter_application_1/Widgets/day_select.dart';
import 'Testes Cognitivos/MEEM/dados_do_paciente.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/get_position.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kCorDoTema,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: SelecionarExame(),
    ),
  );
}
// 1° - LoginTela()
// 2° - TelaInicial()
// 3° - TestesCognitivos()
// 4° - MEEM()
// 5° - CadastroDePaciente()
// 6° - DadosDoPaciente(),
// 7° - GetPosition(),
// 8° - SelecionarExame(),