import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/texto_responsivo.dart';
import 'package:geocoding/geocoding.dart';

import 'meem.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/perguntas.dart';
import 'package:flutter_application_1/Widgets/botaopadrao.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/Usuarios_e_Pacientes/paciente.dart';
import 'get_position.dart';
import 'dart:math' as math; //

// Instância da classe das perguntas do exame
Perguntas perguntas = Perguntas();
// Antes de iniciar o exame, o profissional vai informar alguns dados do paciente
//
// Variáveis referentes a essa página:

Paciente novoPaciente = Paciente();

TextEditingController nomeDoPacienteControlador = TextEditingController();
TextEditingController idadeDoPacienteControlador = TextEditingController();
//
//
TextEditingController localDoExame = TextEditingController();
TextEditingController localEspecifico = TextEditingController();
//
//

enum escolaridadeDoPaciente {
  Analfabeto,
  UmAQuatro,
  CincoAOito,
  NoveOuMais,
  nulo
}

escolaridadeDoPaciente escolaridade = escolaridadeDoPaciente.nulo;

class DadosDoPaciente extends StatefulWidget {
  const DadosDoPaciente({Key? key}) : super(key: key);

  @override
  _DadosDoPacienteState createState() => _DadosDoPacienteState();
}

class _DadosDoPacienteState extends State<DadosDoPaciente> {
  void atribuirDadosDoPaciente() {
    setState(() {});
    novoPaciente
        .atribuirNome(nomeDoPacienteControlador.text.trimRight().trimLeft());
    novoPaciente.atribuirIdade(
      int.parse(idadeDoPacienteControlador.text),
      //
    );

    if (escolaridade == escolaridadeDoPaciente.Analfabeto) {
      novoPaciente.atribuirEscolaridade('Analfabeto', escolaridade);
    } else if (escolaridade == escolaridadeDoPaciente.UmAQuatro) {
      novoPaciente.atribuirEscolaridade(
          '1 a 4 anos de escolaridade', escolaridade);
    } else if (escolaridade == escolaridadeDoPaciente.CincoAOito) {
      novoPaciente.atribuirEscolaridade(
          '5 a 8 anos de escolaridade', escolaridade);
    } else if (escolaridade == escolaridadeDoPaciente.NoveOuMais) {
      novoPaciente.atribuirEscolaridade(
          '9 ou mais anos de escolaridade', escolaridade);
    }
  }

  GlobalKey<FormState> _local_formkey = GlobalKey<FormState>();
  GlobalKey<FormState> _local_especifico_formkey = GlobalKey<FormState>();
  GlobalKey<FormState> _paciente_nome_formkey = GlobalKey<FormState>();
  GlobalKey<FormState> _paciente_idade_formkey = GlobalKey<FormState>();

  void selecionarProsseguir() {
    atribuirDadosDoPaciente();
    perguntas.editarPerguntasDeLocalidade(
      local: localDoExame.text.toLowerCase().trimRight().trimLeft(),
      localEspecifico:
          localEspecifico.text.toLowerCase().trimRight().trimLeft(),
    );

    //  Future test1 = updatePosition();
    //String test2 = retornarLocalidade();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MEEM(),
      ),
    );
  }

  double _maxValue({required double value, required double max}) {
    if (value < max) {
      return value;
    } else
      return max;
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      //automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );

    var appBarHeight =
        appbar.preferredSize.height + MediaQuery.of(context).padding.top;

    var size = MediaQuery.of(context).size;
    var screenHeight = size.height - appBarHeight;
    var labelsize = screenHeight * .03;
    var cursorsize = screenHeight * .04;
    var containerSize = screenHeight * .47;

    //
    //

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kMargemDosWidgets),
                        child: Text(
                          'Antes de prosseguir para o exame, preencha algumas informações.',
                          style: TextStyle(
                            fontSize:
                                _maxValue(value: screenHeight * .1, max: 25),
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: kMargemDosWidgets, top: kMargemDosWidgets),
                      child: CircleAvatar(
                        radius: 35,
                        child: Image(
                          image: AssetImage(kLogoImage),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * .05),
                Text(
                  'Dados do Paciente',
                  style: TextStyle(
                      fontSize: _maxValue(value: screenHeight * .06, max: 35),
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * .03),

                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: respostaMeem(
                      label: 'Nome do Paciente',
                      controlador: nomeDoPacienteControlador,
                      altura: screenHeight * alturaDaCaixaDeTexto,
                      labelSize: labelsize,
                      cursorSize: cursorsize,
                      validador: _paciente_nome_formkey),
                ),
                SizedBox(height: screenHeight * .03),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: respostaMeem(
                      label: 'Idade do Paciente',
                      controlador: idadeDoPacienteControlador,
                      altura: screenHeight * alturaDaCaixaDeTexto,
                      labelSize: labelsize,
                      cursorSize: cursorsize,
                      validador: _paciente_idade_formkey,
                      isNumber: true),
                ),
                SizedBox(height: screenHeight * .04),

                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: Text(
                    'Informe quantos anos de escolaridade tem o paciente:',
                    style: TextStyle(
                        fontSize: _maxValue(value: screenHeight * .05, max: 34),
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: Row(
                    children: [
                      Expanded(
                        child: BotaoPadrao(
                          altura: screenHeight * .1,
                          aoPressionar: () {
                            setState(() {
                              escolaridade = escolaridadeDoPaciente.Analfabeto;
                            });
                          },
                          botaoTexto: 'Analfabeto',
                          //textSize: .5,
                          corDoBotao:
                              escolaridade == escolaridadeDoPaciente.Analfabeto
                                  ? kCorAtiva
                                  : kCorInativa,
                          max_height: 29,
                        ),
                      ),
                      SizedBox(width: size.width * .04),
                      Expanded(
                          child: BotaoPadrao(
                        altura: screenHeight * .1,
                        aoPressionar: () {
                          setState(() {
                            escolaridade = escolaridadeDoPaciente.UmAQuatro;
                          });
                        },
                        botaoTexto: '1 a 4 anos ',
                        //  textSize: 4,
                        corDoBotao:
                            escolaridade == escolaridadeDoPaciente.UmAQuatro
                                ? kCorAtiva
                                : kCorInativa,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: Row(
                    children: [
                      Expanded(
                        child: BotaoPadrao(
                          altura: screenHeight * .1,
                          aoPressionar: () {
                            setState(() {
                              setState(() {
                                escolaridade =
                                    escolaridadeDoPaciente.CincoAOito;
                              });
                            });
                          },
                          botaoTexto: '5 a 8 anos',
                          // textSize: 4,
                          corDoBotao:
                              escolaridade == escolaridadeDoPaciente.CincoAOito
                                  ? kCorAtiva
                                  : kCorInativa,
                        ),
                      ),
                      SizedBox(width: size.width * .04),
                      Expanded(
                          child: BotaoPadrao(
                        altura: screenHeight * .1,
                        aoPressionar: () {
                          setState(() {
                            escolaridade = escolaridadeDoPaciente.NoveOuMais;
                          });
                        },
                        botaoTexto: '9 ou mais',
                        textSize: .5,
                        corDoBotao:
                            escolaridade == escolaridadeDoPaciente.NoveOuMais
                                ? kCorAtiva
                                : kCorInativa,
                      )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * .13),
                //
                //
                Text(
                  'Dados para o Exame',
                  style: TextStyle(
                      fontSize: _maxValue(value: screenHeight * .06, max: 35),
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * .05),

                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: Text(
                    'Informe o local onde será realizado o exame (ex: hospital, casa, casa de repouso etc.)',
                    style: TextStyle(
                        fontSize: _maxValue(value: screenHeight * .05, max: 30),
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                    //textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: respostaMeem(
                      label: 'Local do exame',
                      controlador: localDoExame,
                      altura: screenHeight * alturaDaCaixaDeTexto,
                      labelSize: labelsize,
                      cursorSize: cursorsize,
                      validador: _local_formkey),
                ),
                SizedBox(height: screenHeight * .05),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: Text(
                    'Informe o cômodo ou local específico onde será realizado o exame (ex: sala, consultório, quarto etc.)',
                    style: TextStyle(
                        fontSize: _maxValue(value: screenHeight * .05, max: 30),
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                    //textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: respostaMeem(
                      label: 'Local específico',
                      controlador: localEspecifico,
                      altura: screenHeight * alturaDaCaixaDeTexto,
                      labelSize: labelsize,
                      cursorSize: cursorsize,
                      validador: _local_especifico_formkey),
                ),
                SizedBox(height: screenHeight * .05),

                //
                //
                //
                //
                Padding(
                  padding: const EdgeInsets.all(kMargemDosWidgets),
                  child: BotaoPadrao(
                    altura: screenHeight * .11,
                    aoPressionar: escolaridade != escolaridadeDoPaciente.nulo
                        ? () {
                            if (_paciente_nome_formkey.currentState!
                                    .validate() &&
                                _paciente_idade_formkey.currentState!
                                    .validate() &&
                                _local_formkey.currentState!.validate() &&
                                _local_especifico_formkey.currentState!
                                    .validate()) {
                              selecionarProsseguir();
                            }
                          }
                        : () {},
                    botaoTexto: 'Prosseguir',
                    textSize: .5,
                    corDoBotao: escolaridade != escolaridadeDoPaciente.nulo
                        ? kCorAtiva
                        : kCorInativa,
                    max_height: 50,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
