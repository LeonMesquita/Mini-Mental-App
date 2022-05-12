import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/corpo_das_perguntas.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/dados_do_paciente.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/gerar_imagens.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/meem.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/perguntas_responsivas.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'package:flutter_application_1/Widgets/remove_accents.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'lista_de_palavras.dart';
import 'numeros_do_calculo.dart';
import 'lista_de_objetos.dart';
import 'get_position.dart';

double tamanho = 0;

var screenHeight = .399;

class Perguntas {
  int calculo = atribuirNumero();

  List<String> palavrasEscolhidas = gerarPalavrasAleatorias();
  //
  dynamic objeto1 = gerarObjeto1();
  dynamic objeto2 = gerarObjeto2();
  int numeroDaPerguntaAtual = 0;

  int contador = 0;

  List<dynamic> respostasComuns = [];

  //
  String month = selecionarMes();
  //
  //
  String diaDaSemana = selecionarDiaDaSemana();
  //
  //
  //String ex = retornarLocalidade();
  //Placemark address = _u;
  // Future<Placemark> ex = updatePosition();

  List<PerguntasEscritas> _perguntas = [
    // 1 PERGUNTAS DE ORIENTAÇÃO

    // 1. ORIENTAÇÃO TEMPORAL
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Temporal',
        enunciado: 'Que dia da semana é hoje?',
        categoriaEspecial: 'dia da semana',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Que dia da semana é hoje?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: weekDay),
    PerguntasEscritas(
      categoriaEspecial: 'dia do mes',
      categoriaDaPergunta: 'Orientação Temporal',
      enunciado: 'Que dia do mês é hoje?',
      questao: PerguntasResponsivas(
        textoDaPergunta: 'Que dia do mês é hoje?',
        textSize: .18,
        max_height: 50,
      ),
      respostaDaQuestao: DateTime.now().day.toString().toLowerCase(),
    ),
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Temporal',
        categoriaEspecial: 'mes atual',
        enunciado: 'Em que mês estamos?',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Em que mês estamos?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: mes),
    PerguntasEscritas(
      categoriaDaPergunta: 'Orientação Temporal',
      categoriaEspecial: 'ano atual',
      enunciado: 'Em que ano estamos?',
      questao: PerguntasResponsivas(
        textoDaPergunta: 'Em que ano estamos?',
        textSize: .18,
        max_height: 50,
      ),
      respostaDaQuestao: DateTime.now().year.toString(),
    ),
    PerguntasEscritas(
      categoriaDaPergunta: 'Orientação Temporal',
      categoriaEspecial: 'hora',
      enunciado: 'Qual é a hora atual?',
      questao: PerguntasResponsivas(
        textoDaPergunta:
            'Qual é a hora atual?\n (Tolerância à critério do examinador)',
        textSize: .16,
        max_height: 50,
      ),
      respostaDaQuestao: 'hora',
    ),
//....................... FIM ....................................
    //
    // 1.2 ORIENTAÇÃO ESPACIAL
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Espacial',
        enunciado: 'Que lugar é este? (hospital, casa etc)',
        categoriaEspecial: 'localidade',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Que lugar é este? (hospital, casa etc)',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: 'hospital'),
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Espacial',
        categoriaEspecial: 'local específico',
        enunciado:
            'Em que local específico estamos? (consultório, dormitório, sala etc)',
        questao: PerguntasResponsivas(
          textoDaPergunta:
              'Em que local específico estamos? (consultório, dormitório, sala etc)',
          textSize: .15,
          max_height: 50,
        ),
        respostaDaQuestao: 'consultório'),

    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Espacial',
        enunciado: 'Em que cidade estamos?',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Em que cidade estamos?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: removeAccents(city)),
    // santa clara county
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Espacial',
        enunciado: 'Em que estado estamos?',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Em que estado estamos?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: removeAccents(state)),
    // california
    // carro tijolo rua
    PerguntasEscritas(
        categoriaDaPergunta: 'Orientação Espacial',
        categoriaEspecial: 'endereço',
        enunciado: 'Em que endereço estamos?',
        questao: PerguntasResponsivas(
          textoDaPergunta: 'Em que endereço estamos?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: null),
    // united states

    //....................... FIM ....................................

    // 2 PERGUNTAS DE RETENÇÃO

    //2.1 MEMÓRIA IMEDIATA
    PerguntasEscritas(
      categoriaDaPergunta: 'Memória Imediata',
      enunciado:
          'Vou lhe dizer 3 palavras e quero que o(a) Sr(a) as repita: \n' +
              selectedWords[0] +
              ', ' +
              selectedWords[1] +
              ', ' +
              selectedWords[2],
      questao: Column(
        children: [
          PerguntasResponsivas(
            textoDaPergunta:
                'Vou lhe dizer 3 palavras e quero que o(a) Sr(a) as repita: \n' +
                    selectedWords[0] +
                    ', ' +
                    selectedWords[1] +
                    ', ' +
                    selectedWords[2],
            textSize: .15,
            max_height: 50,
          ),
        ],
      ),
      respostaDaQuestao: selectedWords,
    ),

    //....................... FIM ....................................

    // 3 ATENÇÃO E CALCULO
    PerguntasEscritas(
      categoriaDaPergunta: 'Atenção e Cálculo',
      enunciado: enunciadoDoCalculo(),
      questao: realizarCalculo(),
      respostaDaQuestao: calc.toString(),
    ),
    PerguntasEscritas(
        categoriaDaPergunta: 'Atenção e Cálculo',
        enunciado: enunciadoDoCalculo(),
        questao: realizarCalculo(),
        respostaDaQuestao: calc.toString()),
    PerguntasEscritas(
        categoriaDaPergunta: 'Atenção e Cálculo',
        enunciado: enunciadoDoCalculo(),
        questao: realizarCalculo(),
        respostaDaQuestao: calc.toString()),
    PerguntasEscritas(
        categoriaDaPergunta: 'Atenção e Cálculo',
        enunciado: enunciadoDoCalculo(),
        questao: realizarCalculo(),
        respostaDaQuestao: calc.toString()),
    PerguntasEscritas(
        categoriaDaPergunta: 'Atenção e Cálculo',
        enunciado: enunciadoDoCalculo(),
        questao: realizarCalculo(),
        respostaDaQuestao: calc.toString()),

    //....................... FIM ....................................

    // 3 MEMÓRIA RECENTE:
    PerguntasEscritas(
        categoriaDaPergunta: 'Memória Recente',
        enunciado:
            'Tente lembrar das 3 palavras repetidas anteriormente e tente repetí-las mais uma vez.',
        questao: PerguntasResponsivas(
          textoDaPergunta:
              'Tente lembrar das 3 palavras repetidas anteriormente e tente repetí-las mais uma vez.',
          textSize: .15,
          max_height: 50,
        ),
        respostaDaQuestao: selectedWords),

    //....................... FIM ....................................

    // 3 LINGUAGEM:
    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: 'nomear objetos',
        enunciado: 'Olhe para os objetos abaixo e tente nomeá-los:',
        questao: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PerguntasResponsivas(
              textoDaPergunta: 'Olhe para os objetos abaixo e tente nomeá-los:',
              textSize: .15,
              max_height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gerarImagens(
                    imageName: obj1.imagePath,
                    imageHeight: .50,
                    imageWidth: .40,
                    avaliableArea: screenHeight,
                  ),
                  gerarImagens(
                    imageName: obj2.imagePath,
                    imageHeight: .50,
                    imageWidth: .40,
                    avaliableArea: screenHeight,
                  ),
                ],
              ),
            ),
          ],
        ),
        respostaDaQuestao: [obj1.imageName, obj2.imageName]),

    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: 'repetir frase',
        enunciado:
            'Vou lhe dizer uma frase e depois que eu terminar, quero que o Sr(a) repita:\n“NEM AQUI, NEM ALI, NEM LÁ”',
        questao: PerguntasResponsivas(
          textoDaPergunta:
              'Vou lhe dizer uma frase e quero que o Sr(a) repita:\n“NEM AQUI, NEM ALI, NEM LÁ”',
          textSize: .16,
          max_height: 50,
        ),
        respostaDaQuestao: 'Frase do Paciente'),

    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: '3 acões',
        enunciado:
            'Vou lhe dar um papel e quando eu o entregar, pegue com sua mão direita, dobre-o na metade com as duas mãos e coloque no chão.',
        questao: PerguntasResponsivas(
          textoDaPergunta:
              'Pegue este papel com sua mão direita, dobre-o na metade com as duas mãos e coloque no chão.',
          textSize: .15,
          max_height: 50,
        ),
        respostaDaQuestao: '3 ações'), //'Realizar 3 comandos'
    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: 'executar comando',
        enunciado:
            'Leia o comando abaixo e execute a ação que está escrita nele: \nFeche os olhos',
        questao: Column(
          children: [
            PerguntasResponsivas(
              textoDaPergunta:
                  'Leia o comando abaixo e execute a ação que está escrita nele: \nFeche os olhos',
              textSize: .15,
              max_height: 50,
            ),
          ],
        ),
        respostaDaQuestao: null),

    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: 'escrever frase',
        enunciado:
            'O Sr(a) poderia escrever uma frase completa de sua escolha?',
        questao: PerguntasResponsivas(
          textoDaPergunta:
              'O Sr(a) poderia escrever uma frase completa de sua escolha?',
          textSize: .18,
          max_height: 50,
        ),
        respostaDaQuestao: 'Frase do Paciente'),

    PerguntasEscritas(
        categoriaDaPergunta: 'Linguagem',
        categoriaEspecial: 'desenho',
        enunciado: 'O Sr(a) poderia copiar esse desenho?',
        questao: Column(
          children: [
            PerguntasResponsivas(
              textoDaPergunta: 'O Sr(a) poderia copiar esse desenho?',
              textSize: .18,
              max_height: 50,
            ),
            SizedBox(height: 10),
            Center(
              child: gerarImagens(
                imageName: 'assets/imagens/desenho.png',
                imageHeight: .5,
                imageWidth: .7,
                avaliableArea: screenHeight,
              ),
            ),
          ],
        ),
        respostaDaQuestao: null),
    //....................... FIM ....................................
  ];

  void editarPerguntasDeLocalidade(
      {required String local, required String localEspecifico}) {
    _perguntas[5].respostaDaQuestao = local;
    _perguntas[6].respostaDaQuestao = localEspecifico;

    //for (int count = 0; count < _perguntas.length; count++) {
    // if (_perguntas[count].categoriaEspecial == 'localidade') {
    //    _perguntas[count].respostaDaQuestao = local;
    //  } else if (_perguntas[count].categoriaEspecial == 'local específico') {
    //    _perguntas[count].respostaDaQuestao = localEspecifico;
    //  }
    //  }
  }

  //
  //
  String mostrarLocalidade() {
    return _perguntas[5].respostaDaQuestao;
  }

  String mostrarLocalEspecifico() {
    return _perguntas[6].respostaDaQuestao;
  }

// Método que exibe as perguntas na tela
  dynamic obterPerguntas() {
    return _perguntas[numeroDaPerguntaAtual].questao;
  }

  String obterEnuncuadoDasPerguntas() {
    return _perguntas[numeroDaPerguntaAtual].enunciado;
  }

// Método que retorna as respostas
  dynamic obterResposta() {
    return _perguntas[numeroDaPerguntaAtual].respostaDaQuestao;
  }

  // Método que incrementa a pergunta

  void proximaPergunta() {
    if (numeroDaPerguntaAtual < _perguntas.length - 1)
      numeroDaPerguntaAtual++;
    else {}
  }

  void perguntaAnterior() {
    if (numeroDaPerguntaAtual > 0)
      numeroDaPerguntaAtual--;
    else {}
  }

// Método que verifica se o exame chegou ao final
  verificarFinal() {
    if (numeroDaPerguntaAtual >= _perguntas.length - 1) {
      return true;
    } else
      return false;
  }

  void setarTamanho(size) {
    tamanho = size;
  }

  ///
  ///
  void resetarPalavras() {
    selectedWords = [];
    palavrasEscolhidas = gerarPalavrasAleatorias();
  }

  String obterCategoriaDaPergunta() {
    return _perguntas[numeroDaPerguntaAtual].categoriaDaPergunta;
  }

  //
  //
  String obterCategoriaEspecial() {
    return _perguntas[numeroDaPerguntaAtual].categoriaEspecial;
  }

  resetaNumeroDasPerguntas() {
    numeroDaPerguntaAtual = 0;
  }

  dynamic retornarPerguntasDeMemoria() {
    contador = 0;
    while (contador < _perguntas.length) {
      if (_perguntas[contador].respostaDaQuestao is List &&
          _perguntas[contador].categoriaDaPergunta == 'Memória Imediata') {
        return _perguntas[contador].respostaDaQuestao;
      } else {
        contador++;
      }
    }
  }

  //
  //
  dynamic retornarPerguntasDosObjetos() {
    contador = 0;
    while (contador < _perguntas.length) {
      if (_perguntas[contador].respostaDaQuestao is List &&
          _perguntas[contador].categoriaDaPergunta == 'Linguagem') {
        return _perguntas[contador].respostaDaQuestao;
      } else {
        contador++;
      }
    }
  }

  dynamic retornarPerguntasComuns() {
    contador = 0;
    while (contador < _perguntas.length) {
      if (_perguntas[contador].respostaDaQuestao != null) {
        respostasComuns.add(_perguntas[contador].respostaDaQuestao);
      }
      contador++;
    }
  }

  @override
  State<StatefulWidget> createState() {
    //  var tela = MediaQuery.of(context).size.height;
    // TODO: implement createState
    throw UnimplementedError();
  }
}

//BuildContext? get context => null;
double gerarImagem() {
  BuildContext? context;
  double imageSize = MediaQuery.of(context!).size.height * .02;
  return imageSize;

  //Image(
  //   image: AssetImage(asset),
  //   height: imageSize,
  //   width: imageSize,
  // );
}

Widget TextoDasPerguntas(String textoDaPergunta) {
  return Container(
    //height: MediaQuery.of(context).size.height * .5,
    child: FittedBox(
      child: Text(
        textoDaPergunta,
        style: kEstiloDasPerguntas,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

String mes = '';

String selecionarMes() {
  switch (DateTime.now().month.toString()) {
    case '1':
      mes = 'Janeiro';
      break;
    case '2':
      mes = 'Fevereiro';
      break;
    case '3':
      mes = 'Março';
      break;
    case '4':
      mes = 'Abril';
      break;
    case '5':
      mes = 'Maio';
      break;
    case '6':
      mes = 'Junho';
      break;
    case '7':
      mes = 'Julho';
      break;
    case '8':
      mes = 'Agosto';
      break;
    case '9':
      mes = 'Setembro';
      break;
    case '10':
      mes = 'Outubro';
      break;
    case '11':
      mes = 'Novembro';
      break;
    case '12':
      mes = 'Dezembro';
      break;
    default:
  }
  return mes;
}

String weekDay = '';
String selecionarDiaDaSemana() {
  switch (DateTime.now().weekday.toString()) {
    case '1':
      weekDay = 'Segunda';

      break;
    case '2':
      weekDay = 'Terça';

      break;
    case '3':
      weekDay = 'Quarta';

      break;
    case '4':
      weekDay = 'Quinta';

      break;
    case '5':
      weekDay = 'Sexta';

      break;
    case '6':
      weekDay = 'Sábado';

      break;
    case '7':
      weekDay = 'Domingo';
      break;
    default:
  }
  return weekDay;
}
