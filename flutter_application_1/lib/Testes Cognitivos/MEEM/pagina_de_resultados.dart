import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/mostrar_respostas.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/texto_responsivo.dart';
import 'package:flutter_application_1/Usuarios_e_Pacientes/paciente.dart';
import 'package:flutter_application_1/Widgets/botaopadrao.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'meem.dart';
import 'dados_do_paciente.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'perguntas.dart';

const kEstiloDoResultado = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

String cognicaoSaldavel = 'Cognição saudável';
String declinioCognitivo = 'Declínio Cognitivo';

class PaginaDeResultados extends StatefulWidget {
  const PaginaDeResultados({Key? key}) : super(key: key);

  @override
  _PaginaDeResultadosState createState() => _PaginaDeResultadosState();
}

class _PaginaDeResultadosState extends State<PaginaDeResultados> {
  String gerarDiagnostico() {
    if (novoPaciente.enumDaEscolaridade == escolaridadeDoPaciente.Analfabeto) {
      if (novoPaciente.pontos_meem >= 17) {
        novoPaciente.atribuirCondicaoMental(cognicaoSaldavel);
      } else {
        novoPaciente.atribuirCondicaoMental(declinioCognitivo);
      }
    }
    //
    //

    else if (novoPaciente.enumDaEscolaridade ==
        escolaridadeDoPaciente.UmAQuatro) {
      if (novoPaciente.pontos_meem >= 22) {
        novoPaciente.atribuirCondicaoMental(cognicaoSaldavel);
      } else {
        novoPaciente.atribuirCondicaoMental(declinioCognitivo);
      }
    }
    //
    //
    else if (novoPaciente.enumDaEscolaridade ==
        escolaridadeDoPaciente.CincoAOito) {
      if (novoPaciente.pontos_meem >= 24) {
        novoPaciente.atribuirCondicaoMental(cognicaoSaldavel);
      } else {
        novoPaciente.atribuirCondicaoMental(declinioCognitivo);
      }
    }
    //
    //
    else if (novoPaciente.enumDaEscolaridade ==
        escolaridadeDoPaciente.NoveOuMais) {
      if (novoPaciente.pontos_meem >= 26) {
        novoPaciente.atribuirCondicaoMental(cognicaoSaldavel);
      } else {
        novoPaciente.atribuirCondicaoMental(declinioCognitivo);
      }
    }

    return novoPaciente.retornarCondicaoMental();
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    var labelsize = screenHeight * .03;
    var cursorsize = screenHeight * .04;
    var buttonSize = screenHeight * .11;
    //
    double alturaContainerResultado = .7;
    //
    double alturaSizedBox = screenHeight * .06;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //  ),
      backgroundColor: Colors.grey.shade500,
      body: Container(
        height: size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .1),
              Text(
                'Resultados',
                style: TextStyle(
                  fontSize: (screenHeight * .45) * .15,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: screenHeight * .72,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35,
                      left: kMargemDosWidgets,
                      right: kMargemDosWidgets),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextoResponsivo(
                        // texto: 'sdndsjovndjvnjdvnjvv',
                        texto: 'Nome do Paciente: ${novoPaciente.nome}',
                        total_area: alturaContainerResultado,
                        percent_area: .05,
                        text_color: kCorInativa,
                      ),
                      SizedBox(height: alturaSizedBox),
                      TextoResponsivo(
                        //texto: 'sdndsjovndjvnjdvnjvv',
                        texto: 'Idade: ${novoPaciente.idade} anos',
                        total_area: alturaContainerResultado,
                        percent_area: .05,
                        text_color: kCorInativa,
                      ),
                      SizedBox(height: alturaSizedBox),
                      TextoResponsivo(
                        //texto: 'sdndsjovndjvnjdvnjvv',
                        texto:
                            'Nível de escolaridade: ${novoPaciente.escolaridade}',
                        total_area: alturaContainerResultado,
                        percent_area: .05,
                        text_color: kCorInativa,
                      ),
                      SizedBox(height: alturaSizedBox),
                      TextoResponsivo(
                        //texto: 'sdndsjovndjvnjdvnjvv',
                        texto:
                            'Pontuação no MEEM: ${novoPaciente.pontos_meem} pontos',
                        total_area: alturaContainerResultado,
                        percent_area: .05,
                        text_color: kCorInativa,
                      ),
                      SizedBox(height: alturaSizedBox),
                      TextoResponsivo(
                        //texto: 'sdndsjovndjvnjdvnjvvvvfvfdvdfvsdvvxvcvv',
                        texto: 'Diagnóstico: ${gerarDiagnostico()}',
                        total_area: alturaContainerResultado,
                        percent_area: .05,
                        text_color: kCorInativa,
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: alturaSizedBox),
              Padding(
                padding: const EdgeInsets.all(kMargemDosWidgets),
                child: BotaoPadrao(
                  aoPressionar: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MostrarRespostas(),
                      ),
                    );
                  },
                  botaoTexto: 'Exibir respostas',
                  altura: buttonSize,
                  textSize: .45,
                  max_height: 40,
                  corDoBotao: kCorInativa,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kMargemDosWidgets),
                child: BotaoPadrao(
                  aoPressionar: () {
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: 'Novo Exame',
                      desc:
                          'Selecione Novo para realizar um exame com um novo paciente ou Repetir para realizar com o mesmo paciente.',
                      buttons: [
                        DialogButton(
                          color: kCorDoTema,
                          //
                          // Opção que reseta o teste
                          child: Text(
                            "Repetir",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            setState(() {
                              resetarExame();
                              novoPaciente.resetarAtributos();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MEEM(),
                                ),
                              );
                            });
                          },
                          width: 120,
                        ),
                        //
                        // Ao clicar nessa opção, é iniciado a série de
                        // perguntas direcionadas ao examinador
                        DialogButton(
                          color: kCorDoTema,
                          child: Text(
                            "Novo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            setState(() {
                              resetarExame();
                              novoPaciente = Paciente();
                              novoPaciente.resetarAtributos();
                              perguntas = Perguntas();
                              nomeDoPacienteControlador =
                                  TextEditingController();
                              idadeDoPacienteControlador =
                                  TextEditingController();
                              escolaridade = escolaridadeDoPaciente.nulo;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DadosDoPaciente(),
                                ),
                              );
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  },
                  botaoTexto: 'Novo Exame',
                  altura: buttonSize,
                  textSize: .45,
                  max_height: 40,
                  corDoBotao: kCorInativa,
                ),
                //  SizedBox(
                //    width: size.width * .03,
                //  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 /* Text(
                'Nome do paciente: jooj \n\n Pontuação: ${novoPaciente.pontos_meem} \n\n Lista: ${jooj}\n\n Lista2: ${respostasDeObjetos}',
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),*/


  /*
  Expanded(
                      child: BotaoPadrao(
                        aoPressionar: () {
                          Alert(
                            context: context,
                            type: AlertType.info,
                            desc:
                                'No momento este botão não faz nada, pois ainda não criamos um banco de dados para salvar os dados do paciente.',
                            buttons: [
                              DialogButton(
                                color: kCorDoTema,
                                //
                                // Opção que reseta o teste
                                child: Text(
                                  "Confirmar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  setState(() {
                                    resetarExame();
                                    novoPaciente.resetarAtributos();
                                    Navigator.pop(context);
                                  });
                                },
                                width: 120,
                              ),
                              //
                            ],
                          ).show();
                        },
                        botaoTexto: 'Salvar',
                        altura: buttonSize,
                        textSize: .5,
                        max_height: 40,
                      ),
                    ),
  
   */