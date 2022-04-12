import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/selecionar_exame.dart';
import 'package:flutter_application_1/Widgets/choice_list.dart';
import 'package:flutter_application_1/Widgets/day_select.dart';
import 'perguntas.dart';
import 'dados_do_paciente.dart';
import 'pagina_de_resultados.dart';
import 'package:flutter_application_1/Widgets/botaopadrao.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'lista_de_respostas.dart';

// Variáveis onde serão armazenados a hora e o minuto
String hora = '';
String minuto = '';
//
// Marcador da pontuação do paciente
int marcadorDePontos = 0;
//
//
// Classe onde serão armazenadas todas as perguntas e as respostas do paciente
ListaDeRespostas respostasDoPaciente = ListaDeRespostas();
//
//
// Variável que recebe o tipo da categoria da pergunta atual
// ela serve para mostrar o nome da categoria na barra do app
String categoriaAtual = perguntas.obterCategoriaDaPergunta();
//
//
// Essa variável recebe o tipo único de cada pergunta, serve apenas para fins de programação
String categoriaEspecial = perguntas.obterCategoriaEspecial();
//
//
// O contador da categoria aparece na barra junto com o nome da categoria
int contadorDaCategoriaAtual = 1;
//
//
//
// Variável dinâmica que recebe a resposta certa de cada pergunta, é usada para o cãlculo do resultado
dynamic resposta = perguntas.obterResposta();
//
//
//
// Controladores do TextFormField
// na maioria das perguntas só se usa o primeiro
// os outros dois são para as perguntas que tem mais de uma resposta
TextEditingController controladorDaBarraDeTexto = TextEditingController();
TextEditingController segundoControladorDeTexto = TextEditingController();
TextEditingController terceiroControladorDeTexto = TextEditingController();
//
//
//
// enum que eu uso para avaliar as respostas do examinador
// é usado nas perguntas onde a resposta é só Sim ou Não
enum condicaoExaminador { sim, nao, nulo }
// A resposta do examinador começa sendo nula
condicaoExaminador respostaDoExaminador = condicaoExaminador.nulo;
condicaoExaminador segundaRespostaDoExaminador = condicaoExaminador.nulo;
condicaoExaminador terceiraRespostaDoExaminador = condicaoExaminador.nulo;

//
//
//
// essas listas é onde serão armazenadas as respostas
//das questões que tem como sua resposta uma lista
// é com elas que serão feitas as comparações com as respostas do paciente
List<dynamic> respostasDeMemoria = [];
List<dynamic> respostasDeObjetos = [];
//
//
//
// essa lista recebe todas as respostas que são apenas uma string normal
List<dynamic> respostasString = [];

//
//
//
// Lista que recebe todos os dias da semana
List<String> weekDays = [
  'Nenhuma das respostas listadas',
  'Segunda',
  'Terça',
  'Quarta',
  'Quinta',
  'Sexta',
  'Sábado',
  'Domingo',
];
//
//
//
// Lista que recebe todos os meses do ano
List<String> months = [
  'Nenhuma das respostas listadas',
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
];

//
//
// enunciado da pergunta do desenho
// serve apenas para ser armazenado na lista de perguntas e respostas
String textoDoDesenho = 'O paciente conseguiu fazer o desenho corretamente?';
//
//
String textoDoEndereco =
    'O paciente conseguiu informar o endereço corretamente?';

//
// enunciados das perguntas das 3 ações
// serve apenas para ser armazenado na lista de perguntas e respostas
List<String> textoDasTresAcoes = [
  'O paciente conseguiu pegar o papel com a mão direita?',
  'O paciente conseguiu dobrar o papel na metade?',
  'O paciente conseguiu colocar o papel no chão?',
];
//
//
//
//
// variável onde será armazenada a frase que o paciente repetir/escrever
String fraseDoPaciente = '';
//
//
//
//
// Cores iniciais dos botões de sim e não
Gradient corDoBotaoSim = kCorInativaGradient;
Gradient corDoBotaoNao = kCorInativaGradient;
//
//
//
// Cor do tema do exame
// em cada categoria, é uma cor diferente
Gradient corDoExame = kCorOrientacaoTemporal;

//
//
// lista onde é armazenada a resposta do examinador a cada pergunta
// no final do exame, ela que é usada para calcular o resultado
List<dynamic> listaDeRespostasDoExaminador = [];
//
//
//
//
// Altura padrão de todos os TextFormFields
double alturaDaCaixaDeTexto = .1;
//
//
//
double alturaDaCaixaDePerguntas = .4;
//
// Tamanho padrão dos textos
double tamanhoDoTexto = .04;
//
//
//
// Altura e largura padrão dos botões
double alturaDoBotao = .1;
double larguraDoBotao = .33;
//
//
//
//
// Função que reseta o exame
void resetarExame() {
  perguntas = Perguntas();
  respostasDoPaciente = ListaDeRespostas();
  perguntas.editarPerguntasDeLocalidade(
    local: localDoExame.text.toLowerCase(),
    localEspecifico: localEspecifico.text.toLowerCase(),
  );

  contadorDaCategoriaAtual = 1;
  categoriaAtual = perguntas.obterCategoriaDaPergunta();
  categoriaEspecial = perguntas.obterCategoriaEspecial();
  resposta = perguntas.obterResposta();
  controladorDaBarraDeTexto = TextEditingController();
  segundoControladorDeTexto = TextEditingController();
  terceiroControladorDeTexto = TextEditingController();
  marcadorDePontos = 0;
  listaDeRespostasDoExaminador = [];

  fraseDoPaciente = '';

  respostaDoExaminador = condicaoExaminador.nulo;
  segundaRespostaDoExaminador = condicaoExaminador.nulo;
  terceiraRespostaDoExaminador = condicaoExaminador.nulo;
  corDoExame = kCorOrientacaoTemporal;
  day_of_month = '';
  diaDaSemana = '';
}

//
//
//
//
// Função onde é realizado o cálculo do resultado
void calcularResultado() {
  marcadorDePontos = 0;
  novoPaciente.pontos_meem = 0;
  List<dynamic> listaReserva = [];
  //
  // começando pelo primeiro elemento da lista de respostas do examinador
  for (int count = 0; count < listaDeRespostasDoExaminador.length; count++) {
    listaReserva = [];
    //
    // A primeira condição é se a resposta for do tipo condicaoExaminador, ou seja, respostas de sim ou não
    if (listaDeRespostasDoExaminador[count] is condicaoExaminador) {
      if (listaDeRespostasDoExaminador[count] == condicaoExaminador.sim) {
        // se a resposta for sim, o paciente marca um ponto
        novoPaciente.atribuirPontosMeem();
        marcadorDePontos++;
      }
      //
      //
      // A outra condição é se a resposta é uma lista
    } else if (listaDeRespostasDoExaminador[count] is List) {
      listaReserva = listaDeRespostasDoExaminador[count];
      //
      // Aqui verifica-se se a lista é composta por elementos do tipo condicaoExaminador
      // no caso, é a pergunta das 3 ações
      if (listaReserva[0] is condicaoExaminador) {
        for (int n = 0; n < listaReserva.length; n++) {
          // para cada elemento da lista que é sim, o paciente marca um ponto
          if (listaReserva[n] == condicaoExaminador.sim) {
            novoPaciente.atribuirPontosMeem();
            marcadorDePontos++;
          }
        }
        //
        //
        // A próxima condição é se a lista tem 4 elementos
        // essa é referente a pergunta da hora.
        // só serão utilizados os dois primeiros elementos da lista, que são a hora e o minuto
        // a lista tem 4 elementos apenas para entrar nessa condição
      }

      /*
      else if (listaReserva.length == 4) {
        //
        // a primeira condição é se a hora e minuto informados são exatamente iguais aos certos
        // se sim, o paciente marca um ponto
        if (listaReserva[1] != null &&
            listaReserva[0] == hora &&
            listaReserva[1] == minuto) {
          novoPaciente.atribuirPontosMeem();
          marcadorDePontos++;
        }
        //
        //
        //
        // Como essa pergunta tem uma tolerância de 5 minutos para mais e para menos,
        // ainda tem mais duas condições.
        // A primeira delas é caso o minuto informado seja maior que o minuto atual
        else if (listaReserva[1] != null &&
            int.parse(listaReserva[1]) > int.parse(minuto)) {
          //
          // se for até no máximo 5 minutos a mais que o minuto atual, ainda é considerado certo
          // e o paciente marca um ponto
          if ((int.parse(listaReserva[1]) <= int.parse(minuto) + 5 &&
                  int.parse(minuto) <= 54) &&
              listaReserva[0] == hora) {
            novoPaciente.atribuirPontosMeem();
            marcadorDePontos++;
          }
          //
          //
          // A outra condição é se o minuto informado for menor que o minuto atual
        } else if (listaReserva[1] != null &&
            int.parse(listaReserva[1]) < int.parse(minuto)) {
          //
          // se ele for no máximo até 5 minutos menor, o paciente marca um ponto
          if (int.parse(listaReserva[1]) >= int.parse(minuto) - 5 &&
              listaReserva[0] == hora) {
            novoPaciente.atribuirPontosMeem();
            marcadorDePontos++;
          }
        }

        //
        //
        //
        // A próxima condição é se a lista tiver 3 elementos
        // Nesse caso é das perguntas onde se tem que decorar as 3 palavras
      } */
      // hora
      //

      else if (listaReserva.length == 3) {
        for (int n = 0; n < listaReserva.length; n++) {
          //
          // para cada item da lista que existe na lista respostasDeMemoria, o paciente marca um ponto
          if (respostasDeMemoria.contains(listaReserva[n])) {
            novoPaciente.atribuirPontosMeem();
            marcadorDePontos++;
          }
        }
        //
        //
        // Por fim, a ultima condição se for uma lista é se tiver apenas 2 elementos
        // Nesse caso é da pergunta de nomear os objetos
      } else {
        for (int n = 0; n < listaReserva.length; n++) {
          //
          // para cada item da lista que existe na lista respostasDeObjetos, o paciente marca um ponto
          if (respostasDeObjetos.contains(listaReserva[n])) {
            novoPaciente.atribuirPontosMeem();
            marcadorDePontos++;
          }
        }
      }
      //
      //
      // E por fim, se a resposta não for uma lista,
      // quer dizer que é apenas um TextField normal
      // então ele apenas verifica se essa string existe na lista de strings
    } else {
      if (respostasString.contains(listaDeRespostasDoExaminador[count])) {
        novoPaciente.atribuirPontosMeem();
        marcadorDePontos++;
      }
    }
    //
    //

  }
}

//
//
//
// Função que atribui a cor tema do exame
// cada vez que a categoria atual muda, a cor é atualizada
void atribuirCores() {
  if (categoriaAtual == 'Orientação Temporal') {
    corDoExame = kCorOrientacaoTemporal;
  } else if (categoriaAtual == 'Orientação Espacial') {
    corDoExame = kCorOrientacaoEspacial;
  } else if (categoriaAtual == 'Memória Imediata') {
    corDoExame = kCorMemoriaImediata;
  } else if (categoriaAtual == 'Atenção e Cálculo') {
    corDoExame = kCorCalculo;
  } else if (categoriaAtual == 'Memória Recente') {
    corDoExame = kCorMemoriaRecente;
  } else if (categoriaAtual == 'Linguagem') {
    corDoExame = kCorLinguagem;
  }
}
//
//
//
//

// inicio da aplicação
class MEEM extends StatefulWidget {
  const MEEM({Key? key}) : super(key: key);

  @override
  _MEEMState createState() => _MEEMState();
}

class _MEEMState extends State<MEEM> {
  //
// Essa função é chamada quando o usuário pressiona o botão de confirmar a resposta
// Ela verifica se o quiz chegou ao fim
  void conferirResposta() {
    setState(() {
      //
      //
      if (categoriaAtual == 'Memória Imediata') {
        respostasDeMemoria = resposta;
      } else if (categoriaAtual == 'Linguagem' && resposta is List) {
        respostasDeObjetos = resposta;
      } else if (resposta != null &&
          resposta != '3 ações' &&
          resposta != 'Frase do Paciente') {
        respostasString.add(resposta);
      }
      //
      //

      //
      // Aqui ele chama o método que verifica se o teste está na última pergunta
      if (perguntas.verificarFinal()) {
        //
        // Se estiver, ele chama esse Alert que informa o fim do teste
        Alert(
          context: context,
          type: AlertType.success,
          title: 'Fim do Teste!',
          desc: 'Calcular o resultado agora?',
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
                  Navigator.pop(context);
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
                "Confirmar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaDeResultados(),
                  ),
                );
                setState(() {
                  calcularResultado();
                });
              },
              width: 120,
            )
          ],
        ).show();

        // Caso não seja a última pergunta, ele chama o método
        // que incrementa para a próxima pergunta
      } else {
        perguntas.proximaPergunta();
      }
    });
  }

  bool esta_correto = true;
  String enunciadoDaPergunta = '';
  //

  void preencherListaDeRespostas() {
    List<dynamic> reserva = [];
    List<dynamic> res_palavras;
    List<String> horas = [];
    String textoDoisObjetos = 'Olhe para os objetos abaixo e tente nomeá-los';
    String textoDasTresPalavras = '';
    String relembrarPalavras =
        'Tente lembrar novamente das 3 palavras repetidas anteriormente e tente repetí-las mais uma vez.';

    var resp_reserva;
    List<String> lista_acoes = [];
    List<bool> list_bool_reserva = [];
    if (resposta == null ||
        resposta == 'Frase do Paciente' ||
        resposta == 'hora') {
      listaDeRespostasDoExaminador.add(respostaDoExaminador);
      //
      //
      // preenchendo a lista de respostas do paciente
      // respostasDoPaciente.preencherListaDeRespostas(
      //  perguntas.obterPerguntas(), respostaDoExaminador);
      if (respostaDoExaminador == condicaoExaminador.sim) {
        resp_reserva = 'Sim';
        esta_correto = true;
        //fraseDoPaciente = '';
      } else {
        resp_reserva = 'Não';
        esta_correto = false;
        if (respostaDoExaminador == condicaoExaminador.nulo) {
          fraseDoPaciente = '';
        }
      }

      if (categoriaEspecial == 'endereço') {
        respostasDoPaciente.preencherListaDeRespostas(
          perg: textoDoEndereco,
          resp: resp_reserva,
          correct: esta_correto,
          list_correct: [true],
        );
      } else if (categoriaEspecial == 'hora') {
        enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
        respostasDoPaciente.preencherListaDeRespostas(
          perg: enunciadoDaPergunta,
          resp: controladorDaBarraDeTexto.text +
              ':' +
              segundoControladorDeTexto.text,
          correct: esta_correto,
          list_correct: [true],
        );
      } else if (categoriaEspecial == 'desenho') {
        respostasDoPaciente.preencherListaDeRespostas(
          perg: textoDoDesenho,
          resp: resp_reserva,
          correct: esta_correto,
          list_correct: [true],
        );
      } else if (categoriaEspecial == 'executar comando') {
        enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
        respostasDoPaciente.preencherListaDeRespostas(
          perg: enunciadoDaPergunta +
              '.\n' +
              'O paciente conseguiu executar o comando corretamente?',
          resp: resp_reserva,
          correct: esta_correto,
          list_correct: [true],
        );
      } else if (categoriaEspecial == 'escrever frase') {
        enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
        fraseDoPaciente = controladorDaBarraDeTexto.text.trimRight().trimLeft();
        respostasDoPaciente.preencherListaDeRespostas(
          perg:
              'O paciente conseguiu escrever uma frase de sua autoria corretamente?\n' +
                  'Frase do paciente: ${fraseDoPaciente}',
          resp: resp_reserva,
          correct: esta_correto,
          list_correct: [true],
        );
      } else if (categoriaEspecial == 'repetir frase') {
        enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
        fraseDoPaciente = controladorDaBarraDeTexto.text.trimRight().trimLeft();

        //
        //

        if (resp_reserva != 'Não') {
          fraseDoPaciente = 'NEM AQUI, NEM ALI, NEM LÁ';
        }

        //
        //

        respostasDoPaciente.preencherListaDeRespostas(
          perg: 'O paciente conseguiu repetir a frase corretamente?\n' +
              'Frase dita pelo paciente: ${fraseDoPaciente}',
          resp: resp_reserva,
          correct: esta_correto,
          list_correct: [true],
        );
      }
    }
    //
    //
    else if (categoriaAtual == 'Memória Imediata' ||
        categoriaAtual == 'Memória Recente') {
      reserva.add(
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft());
      reserva.add(
          segundoControladorDeTexto.text.toLowerCase().trimRight().trimLeft());
      reserva.add(
          terceiroControladorDeTexto.text.toLowerCase().trimRight().trimLeft());
      //
      listaDeRespostasDoExaminador.add(reserva);
      //
      //
      //list_resp_reserva.add(reserva[0]);
      //list_resp_reserva.add(reserva[1]);
      // list_resp_reserva.add(reserva[2]);

      res_palavras = perguntas.obterResposta();

      if (res_palavras.contains(reserva[0])) {
        list_bool_reserva.add(true);
      } else {
        list_bool_reserva.add(false);
      }
      if (res_palavras.contains(reserva[1])) {
        list_bool_reserva.add(true);
      } else {
        list_bool_reserva.add(false);
      }
      if (res_palavras.contains(reserva[2])) {
        list_bool_reserva.add(true);
      } else {
        list_bool_reserva.add(false);
      }

      textoDasTresPalavras =
          'Vou lhe dizer 3 palavras e quero que o(a) Sr(a) as repita: ' +
              res_palavras[0] +
              ', ' +
              res_palavras[1] +
              ', ' +
              res_palavras[2];
      //
      // preenchendo a lista de respostas do paciente
      resp_reserva = reserva[0] + ', ' + reserva[1] + ', ' + reserva[2];
      respostasDoPaciente.preencherListaDeRespostas(
        perg: categoriaAtual == 'Memória Imediata'
            ? textoDasTresPalavras
            : relembrarPalavras,
        resp: reserva,
        correct: true,
        list_correct: list_bool_reserva,
      );
    }
    //
    //
    else if (categoriaAtual == 'Linguagem' && resposta is List) {
      reserva.add(
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft());
      reserva.add(
          segundoControladorDeTexto.text.toLowerCase().trimRight().trimLeft());
      //
      listaDeRespostasDoExaminador.add(reserva);
      //
      //
      res_palavras = perguntas.obterResposta();
      //
      //
      if (res_palavras.contains(reserva[0])) {
        list_bool_reserva.add(true);
      } else {
        list_bool_reserva.add(false);
      }
      if (res_palavras.contains(reserva[1])) {
        list_bool_reserva.add(true);
      } else {
        list_bool_reserva.add(false);
      }
      // preenchendo a lista de respostas do paciente

      respostasDoPaciente.preencherListaDeRespostas(
        perg: textoDoisObjetos,
        resp: reserva,
        correct: true,
        list_correct: list_bool_reserva,
      );
    }
    //
    else if (resposta == '3 ações') {
      reserva.add(respostaDoExaminador);
      reserva.add(segundaRespostaDoExaminador);
      reserva.add(terceiraRespostaDoExaminador);

      listaDeRespostasDoExaminador.add(reserva);
      //
      if (reserva[0] == condicaoExaminador.sim) {
        lista_acoes.add('Sim');
        list_bool_reserva.add(true);
      } else {
        lista_acoes.add('Não');
        list_bool_reserva.add(false);
      }
      //
      if (reserva[1] == condicaoExaminador.sim) {
        lista_acoes.add('Sim');
        list_bool_reserva.add(true);
      } else {
        lista_acoes.add('Não');
        list_bool_reserva.add(false);
      }
      //
      if (reserva[2] == condicaoExaminador.sim) {
        lista_acoes.add('Sim');
        list_bool_reserva.add(true);
      } else {
        lista_acoes.add('Não');
        list_bool_reserva.add(false);
      }
      //
      // preenchendo a lista de respostas do paciente
      respostasDoPaciente.preencherListaDeRespostas(
        perg: textoDasTresAcoes[0] +
            '\n' +
            textoDasTresAcoes[1] +
            '\n' +
            textoDasTresAcoes[2],
        resp: lista_acoes,
        correct: true,
        list_correct: list_bool_reserva,
      );
    }
    //
    //
    else if (categoriaEspecial == 'dia da semana') {
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
      listaDeRespostasDoExaminador.add(diaDaSemana);
      if (diaDaSemana == resposta) {
        esta_correto = true;
      } else {
        esta_correto = false;
      }
      //
      //
      // preenchendo a lista de respostas do paciente
      //resp_reserva = perguntas.obterPerguntas();
      //respostasDoPaciente.preencherListaDeRespostas(
      //   'resp_reserva', diaDaSemana);
      // respostasDoPaciente.preencherListaDeRespostas(resp_reserva, diaDaSemana);
      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp: diaDaSemana,
        correct: esta_correto,
        list_correct: [true],
      );
    }
    //
    //
    else if (categoriaEspecial == 'mes atual') {
      listaDeRespostasDoExaminador.add(mesAtual);
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();

      if (mesAtual == resposta) {
        esta_correto = true;
      } else {
        esta_correto = false;
      }
      //
      //
      // preenchendo a lista de respostas do paciente
      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp: mesAtual,
        correct: esta_correto,
        list_correct: [true],
      );
    }
    //
    else if (categoriaEspecial == 'dia do mes') {
      listaDeRespostasDoExaminador.add(day_of_month);
      //
      //
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();

      if (day_of_month == resposta) {
        esta_correto = true;
      } else {
        esta_correto = false;
      }
      //
      //
      // preenchendo a lista de respostas do paciente
      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp: day_of_month,
        correct: esta_correto,
        list_correct: [true],
      );
    }
    //
    //
    /*
    else if (categoriaEspecial == 'hora') {
      reserva.add(controladorDaBarraDeTexto.text);
      reserva.add(segundoControladorDeTexto.text);
      reserva.add(controladorDaBarraDeTexto.text);
      reserva.add(segundoControladorDeTexto.text);
//
//
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();
      hora = DateTime.now().hour.toString();
      minuto = DateTime.now().minute.toString();
      //hora = DateTime.now().hour.toString();
      // minuto = DateTime.now().minute.toString();
      listaDeRespostasDoExaminador.add(reserva);
      //
      horas = perguntas.obterResposta();
      //
      //

      if (reserva[0] == hora && reserva[1] == minuto) {
        esta_correto = true;
        list_bool_reserva.add(true);
      }
      //
      //
      else if (reserva[1] != null &&
          int.parse(reserva[1]) > int.parse(minuto)) {
        if ((int.parse(reserva[1]) <= int.parse(minuto) + 5 &&
                int.parse(minuto) <= 54) &&
            reserva[0] == hora) {
          esta_correto = true;
          list_bool_reserva.add(true);
        }
        //
        //
      } else if (reserva[1] != null &&
          int.parse(reserva[1]) < int.parse(minuto)) {
        if (int.parse(reserva[1]) >= int.parse(minuto) - 5 &&
            reserva[0] == hora) {
          esta_correto = true;
          list_bool_reserva.add(true);
        }
      }
      //

      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp: reserva,
        correct: esta_correto,
        list_correct: list_bool_reserva,
      );
    }
    */
    //
    //
    //
    //
    //
    //
    //
    //
    else {
      listaDeRespostasDoExaminador.add(
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft());
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();

      if (controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft() ==
          resposta) {
        esta_correto = true;
      } else {
        esta_correto = false;
      }
      //
      //
      // preenchendo a lista de respostas do paciente
      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp:
            controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft(),
        correct: esta_correto,
        list_correct: [true],
      );
      //
      //
      // preenchendo a lista de respostas do paciente
      //respostasDoPaciente.preencherListaDeRespostas(perguntas.obterPerguntas(),
      //   controladorDaBarraDeTexto.text.toLowerCase());
    }
    //
  }

  //
  //
  GlobalKey<FormState> _primeiro_textfield_formkey = GlobalKey<FormState>();
  //
  GlobalKey<FormState> _segundo_textfield_formkey = GlobalKey<FormState>();
  //
  GlobalKey<FormState> _terceiro_textfield_formkey = GlobalKey<FormState>();
  //
  //
  void apertarConfirmar() {
    setState(() {
      preencherListaDeRespostas();

      conferirResposta();
      //
      //

      //
      // A variável dinânica 'resposta' recebe o conteúdo do atributo resposta da classe
      resposta = perguntas.obterResposta();

      //
      // Os controladores de texto são resetados
      controladorDaBarraDeTexto = TextEditingController();
      segundoControladorDeTexto = TextEditingController();
      terceiroControladorDeTexto = TextEditingController();
      //
      // Essa parte serve apenas para receber a categoria
      // da pergunta, para exibir ela na barra do App.

      //
      //
      categoriaEspecial = perguntas.obterCategoriaEspecial();

      if (perguntas.obterCategoriaDaPergunta() != categoriaAtual) {
        //
        // Ela só vai ser alterada quando a categoria da pergunta mudar

        categoriaAtual = perguntas.obterCategoriaDaPergunta();
        atribuirCores();
      }
      respostaDoExaminador = condicaoExaminador.nulo;
      segundaRespostaDoExaminador = condicaoExaminador.nulo;
      terceiraRespostaDoExaminador = condicaoExaminador.nulo;
    });
  }

  double _maxValue({required double value, required double max}) {
    if (value < max) {
      return value;
    } else
      return max;
  }

  @override
  Widget build(BuildContext context) {
    var appbarTest = NewGradientAppBar();
    var appbar = NewGradientAppBar(
      gradient: corDoExame,
      title: Text(
        '${perguntas.obterCategoriaDaPergunta()}',
        style: TextStyle(
            fontSize: appbarTest.preferredSize.height * .3,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      //
      // Ícones que ficam na barra
      actions: [
        IconButton(
          // Ícone de refresh que fica na barra, ele reseta o teste
          icon: Icon(Icons.refresh),
          onPressed: () {
            Alert(
              context: context,
              type: AlertType.warning,
              title: 'Tem certeza de que deseja resetar o exame?',
              buttons: [
                DialogButton(
                  color: kCorDoTema,
                  child: Text(
                    "Cancelar",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                ),
                DialogButton(
                  color: kCorDoTema,
                  child: Text(
                    "Confirmar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  //
                  // Resetando o exame...
                  onPressed: () {
                    setState(() {
                      resetarExame();
                      Navigator.pop(context);
                    });
                  },
                  width: 120,
                ),
              ],
            ).show();
          },
        ),
        //
        // Botão que leva para a página inicial
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelecionarExame(),
              ),
            );
          },
          icon: Icon(Icons.home),
        ),
      ],
    );
    //
    var size = MediaQuery.of(context).size;

    //
    //
    var imageSize = size.height * .05;

    perguntas.setarTamanho(imageSize);

    //
    //
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    //
    //

    var boxHeight = screenHeight * daySize;
    var boxWidth = size.width * dayWidth;
    //
    //
    var labelsize = screenHeight * .03;
    var cursorsize = screenHeight * .04;
    return Scaffold(
      appBar: appbar,
      // resizeToAvoidBottomInset: false,

      // Esse appBar é de um pacote que eu baixei
      // ele permite deixar o appBar com cor gradiente
//
//

      //
      //  AQUI COMEÇA O EXAME
      //

      /*
          ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width),
          child
      */
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            // Aqui é chamado o container onde ficam as perguntas
            containerDasRespostas(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  SizedBox(
                    //    height: size.height * .02,
                    // ),
                    //
                    // A pergunta é chamada aqui
                    perguntas.obterPerguntas() is String
                        //
                        // Aqui ele verifica se a pergunta é apenas uma string normal
                        ? Text(
                            //
                            //
                            // Se for, ele só retorna um texto na tela mesmo
                            perguntas.obterPerguntas(),
                            textAlign: TextAlign.center,
                            style: kEstiloDasPerguntas,
                          )
                        //
                        // Se a pergunta não for uma string, significa que é um widget
                        // Nesse caso ele exibe o widget na tela
                        : perguntas.obterPerguntas(),
                  ],
                ),
              ),
              screenHeight * .4,
            ),
            //SizedBox(height: 90),
            //
            // Aqui é verificado se a pergunta é do tipo memória imediata ou memória recente
            // Ambas tem a mesma resposta

            Container(
              // color: Colors.yellow.shade100,
              // height: screenHeight * .43,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: kMargemDosWidgets, right: kMargemDosWidgets),
                child: categoriaAtual == 'Memória Imediata' ||
                        categoriaAtual == 'Memória Recente'
                    ? Container(
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //
                            // Caso seja verdadeiro, é retornado 3 TextFormFields
                            // Um para cada palavra

                            children: [
                              SizedBox(height: screenHeight * .07),
                              respostaMeem(
                                  label: 'Primeira palavra',
                                  controlador: controladorDaBarraDeTexto,
                                  altura: screenHeight * alturaDaCaixaDeTexto,
                                  labelSize: labelsize,
                                  cursorSize: cursorsize,
                                  validador: _primeiro_textfield_formkey,
                                  isNumber: false),
                              SizedBox(height: screenHeight * .05),
                              respostaMeem(
                                  label: 'Segunda palavra',
                                  controlador: segundoControladorDeTexto,
                                  altura: screenHeight * alturaDaCaixaDeTexto,
                                  labelSize: labelsize,
                                  cursorSize: cursorsize,
                                  validador: _segundo_textfield_formkey,
                                  isNumber: false),
                              SizedBox(height: screenHeight * .05),
                              respostaMeem(
                                  label: 'Terceira palavra',
                                  controlador: terceiroControladorDeTexto,
                                  altura: screenHeight * alturaDaCaixaDeTexto,
                                  labelSize: labelsize,
                                  cursorSize: cursorsize,
                                  validador: _terceiro_textfield_formkey,
                                  isNumber: false),
                              SizedBox(height: screenHeight * .06),
                            ],
                          ),
                        ),
                      )
                    //
                    // Caso não seja, ele vai para a próxima condição

                    : Container(
                        //
                        // Aqui ele verifica se é a pergunta que pede para
                        // o paciente olhar dois objetos e nomear eles
                        child:
                            resposta is List &&
                                    categoriaAtual ==
                                        'Linguagem' //== ['caneta', 'relógio']
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Caso seja, ele retorna dois textformfields para armazenar as respostas

                                    children: [
                                      SizedBox(height: screenHeight * .1),
                                      respostaMeem(
                                          label: 'Primeiro objeto',
                                          controlador:
                                              controladorDaBarraDeTexto,
                                          altura: screenHeight *
                                              alturaDaCaixaDeTexto,
                                          labelSize: labelsize,
                                          cursorSize: cursorsize,
                                          validador:
                                              _primeiro_textfield_formkey),
                                      SizedBox(height: screenHeight * .07),
                                      respostaMeem(
                                          label: 'Segundo objeto',
                                          controlador:
                                              segundoControladorDeTexto,
                                          altura: screenHeight *
                                              alturaDaCaixaDeTexto,
                                          labelSize: labelsize,
                                          cursorSize: cursorsize,
                                          validador:
                                              _segundo_textfield_formkey),
                                      SizedBox(height: screenHeight * .085),
                                    ],
                                  )
                                : Container(
                                    //
                                    // Aqui ele verifica se a pergunta tem uma resposta nula
                                    // ou seja, nenhuma resposta.
                                    // essas são as perguntas que o próprio examinador
                                    // vai avaliar se estão certas ou não
                                    child: resposta == null
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                  height: screenHeight * .07),
                                              Container(
                                                height: _maxValue(
                                                    value: screenHeight * .35,
                                                    max: 235),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: Offset(1, 4),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 2.5),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      11.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      categoriaEspecial ==
                                                              'endereço'
                                                          ? textoDeConfirmacao(
                                                              'O paciente conseguiu informar o endereço corretamente?',
                                                              screenHeight *
                                                                  tamanhoDoTexto)
                                                          : textoDeConfirmacao(
                                                              categoriaEspecial ==
                                                                      'executar comando'
                                                                  ? 'O paciente conseguiu executar o comando corretamente?'
                                                                  : textoDoDesenho,
                                                              screenHeight *
                                                                  tamanhoDoTexto),

                                                      //

                                                      //
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              height: _maxValue(
                                                                  value: screenHeight *
                                                                      alturaDoBotao,
                                                                  max: 235),
                                                              width: size
                                                                      .width *
                                                                  larguraDoBotao,
                                                              child:
                                                                  BotaoPadrao(
                                                                altura: screenHeight *
                                                                    alturaDoBotao,
                                                                corDoBotao: respostaDoExaminador ==
                                                                        condicaoExaminador
                                                                            .nao
                                                                    ? kPurpleColor
                                                                    : kCorInativa,
                                                                botaoTexto:
                                                                    'Não',
                                                                aoPressionar:
                                                                    () {
                                                                  setState(() {
                                                                    respostaDoExaminador =
                                                                        condicaoExaminador
                                                                            .nao;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              height: _maxValue(
                                                                  value: screenHeight *
                                                                      alturaDoBotao,
                                                                  max: 235),
                                                              width: size
                                                                      .width *
                                                                  larguraDoBotao,
                                                              child:
                                                                  BotaoPadrao(
                                                                altura: screenHeight *
                                                                    alturaDoBotao,
                                                                aoPressionar:
                                                                    () {
                                                                  setState(() {
                                                                    respostaDoExaminador =
                                                                        condicaoExaminador
                                                                            .sim;
                                                                  });
                                                                },
                                                                corDoBotao: respostaDoExaminador ==
                                                                        condicaoExaminador
                                                                            .sim
                                                                    ? kPurpleColor
                                                                    : kCorInativa,
                                                                botaoTexto:
                                                                    'Sim',
                                                              ),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight * .08),
                                            ],
                                          )
                                        :
                                        //
                                        // Por fim, caso não seja nenhuma das outras condições,
                                        // significa que a pergunta é só um texto normal que tem
                                        // como resposta outro texto
                                        Container(
                                            child:
                                                resposta == 'Frase do Paciente'
                                                    ? SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        .07),
                                                            Container(
                                                              height: _maxValue(
                                                                  value:
                                                                      screenHeight *
                                                                          .35,
                                                                  max: 235),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        8,
                                                                    offset:
                                                                        Offset(
                                                                            1,
                                                                            4),
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2.5),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        11.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    textoDeConfirmacao(
                                                                        categoriaEspecial ==
                                                                                'repetir frase'
                                                                            ? 'O paciente conseguiu repetir a frase corretamente?'
                                                                            : 'O paciente conseguiu escrever uma frase corretamente?',
                                                                        screenHeight *
                                                                            tamanhoDoTexto),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          height: _maxValue(
                                                                              value: screenHeight * alturaDoBotao,
                                                                              max: 100),
                                                                          width:
                                                                              size.width * larguraDoBotao,
                                                                          child:
                                                                              BotaoPadrao(
                                                                            altura:
                                                                                _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                            corDoBotao: respostaDoExaminador == condicaoExaminador.nao
                                                                                ? kPurpleColor
                                                                                : kCorInativa,
                                                                            botaoTexto:
                                                                                'Não',
                                                                            aoPressionar:
                                                                                () {
                                                                              setState(() {
                                                                                respostaDoExaminador = condicaoExaminador.nao;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              screenHeight * alturaDoBotao,
                                                                          width:
                                                                              size.width * larguraDoBotao,
                                                                          child:
                                                                              BotaoPadrao(
                                                                            aoPressionar:
                                                                                () {
                                                                              setState(() {
                                                                                respostaDoExaminador = condicaoExaminador.sim;
                                                                              });
                                                                            },
                                                                            corDoBotao: respostaDoExaminador == condicaoExaminador.sim
                                                                                ? kPurpleColor
                                                                                : kCorInativa,
                                                                            botaoTexto:
                                                                                'Sim',
                                                                            altura:
                                                                                screenHeight * alturaDoBotao,
                                                                          ),
                                                                        ),
                                                                        //
                                                                        //
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        .05),
                                                            //

                                                            //
                                                            categoriaEspecial ==
                                                                        'repetir frase' &&
                                                                    respostaDoExaminador !=
                                                                        condicaoExaminador
                                                                            .nao
                                                                ? SizedBox(
                                                                    height:
                                                                        screenHeight *
                                                                            .00)
                                                                : respostaMeem(
                                                                    label:
                                                                        categoriaEspecial == 'repetir frase'
                                                                            ? 'Resposta do Paciente'
                                                                            : 'Frase do Paciente',
                                                                    controlador:
                                                                        controladorDaBarraDeTexto,
                                                                    altura: screenHeight *
                                                                        alturaDaCaixaDeTexto,
                                                                    labelSize:
                                                                        labelsize,
                                                                    cursorSize:
                                                                        cursorsize,
                                                                    validador:
                                                                        _primeiro_textfield_formkey),
                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        .03),
                                                          ],
                                                        ),
                                                      )
                                                    //
                                                    //
                                                    //
                                                    : Container(
                                                        child: resposta ==
                                                                '3 ações'
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          screenHeight *
                                                                              .1),
                                                                  Container(
                                                                    height: _maxValue(
                                                                        value: screenHeight *
                                                                            .35,
                                                                        max:
                                                                            235),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.grey,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              8,
                                                                          offset: Offset(
                                                                              1,
                                                                              4),
                                                                        ),
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              2.5),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          11.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Primeira ação',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 22,
                                                                              color: kCorDoTema,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          textoDeConfirmacao(
                                                                              textoDasTresAcoes[0],
                                                                              screenHeight * tamanhoDoTexto),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Container(
                                                                                height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                width: size.width * larguraDoBotao,
                                                                                child: BotaoPadrao(
                                                                                  corDoBotao: respostaDoExaminador == condicaoExaminador.nao ? kPurpleColor : kCorInativa,
                                                                                  botaoTexto: 'Não',
                                                                                  altura: screenHeight * alturaDoBotao,
                                                                                  aoPressionar: () {
                                                                                    setState(() {
                                                                                      respostaDoExaminador = condicaoExaminador.nao;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                width: size.width * larguraDoBotao,
                                                                                child: BotaoPadrao(
                                                                                  aoPressionar: () {
                                                                                    setState(() {
                                                                                      respostaDoExaminador = condicaoExaminador.sim;
                                                                                    });
                                                                                  },
                                                                                  corDoBotao: respostaDoExaminador == condicaoExaminador.sim ? kPurpleColor : kCorInativa,
                                                                                  botaoTexto: 'Sim',
                                                                                  altura: screenHeight * alturaDoBotao,
                                                                                ),
                                                                              ),
                                                                              //
                                                                              //
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //     height:
                                                                  //        screenHeight *
                                                                  //           .03),
                                                                  ///    SizedBox(
                                                                  //     height:
                                                                  //        screenHeight *
                                                                  //             .1,
                                                                  //   ),

                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            30),
                                                                    child:
                                                                        Container(
                                                                      height: _maxValue(
                                                                          value: screenHeight *
                                                                              .35,
                                                                          max:
                                                                              235),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 3),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                8,
                                                                            offset:
                                                                                Offset(1, 4),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(11.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Segunda ação',
                                                                              style: TextStyle(
                                                                                fontSize: 22,
                                                                                color: kCorDoTema,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            textoDeConfirmacao(textoDasTresAcoes[1],
                                                                                screenHeight * tamanhoDoTexto),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                  width: size.width * larguraDoBotao,
                                                                                  child: BotaoPadrao(
                                                                                    corDoBotao: segundaRespostaDoExaminador == condicaoExaminador.nao ? kPurpleColor : kCorInativa,
                                                                                    botaoTexto: 'Não',
                                                                                    altura: screenHeight * alturaDoBotao,
                                                                                    aoPressionar: () {
                                                                                      setState(() {
                                                                                        segundaRespostaDoExaminador = condicaoExaminador.nao;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                  width: size.width * larguraDoBotao,
                                                                                  child: BotaoPadrao(
                                                                                    aoPressionar: () {
                                                                                      setState(() {
                                                                                        segundaRespostaDoExaminador = condicaoExaminador.sim;
                                                                                      });
                                                                                    },
                                                                                    corDoBotao: segundaRespostaDoExaminador == condicaoExaminador.sim ? kPurpleColor : kCorInativa,
                                                                                    botaoTexto: 'Sim',
                                                                                    altura: screenHeight * alturaDoBotao,
                                                                                  ),
                                                                                ),
                                                                                //
                                                                                //
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  ///
                                                                  /////
                                                                  ///
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            30),
                                                                    child:
                                                                        Container(
                                                                      height: _maxValue(
                                                                          value: screenHeight *
                                                                              .35,
                                                                          max:
                                                                              235),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 3),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                8,
                                                                            offset:
                                                                                Offset(1, 4),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(11.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Terceira ação',
                                                                              style: TextStyle(
                                                                                fontSize: 23,
                                                                                color: kCorDoTema,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            textoDeConfirmacao(textoDasTresAcoes[2],
                                                                                screenHeight * tamanhoDoTexto),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                  width: size.width * larguraDoBotao,
                                                                                  child: BotaoPadrao(
                                                                                    corDoBotao: terceiraRespostaDoExaminador == condicaoExaminador.nao ? kPurpleColor : kCorInativa,
                                                                                    botaoTexto: 'Não',
                                                                                    altura: screenHeight * alturaDoBotao,
                                                                                    aoPressionar: () {
                                                                                      setState(() {
                                                                                        terceiraRespostaDoExaminador = condicaoExaminador.nao;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                  width: size.width * larguraDoBotao,
                                                                                  child: BotaoPadrao(
                                                                                    aoPressionar: () {
                                                                                      setState(() {
                                                                                        terceiraRespostaDoExaminador = condicaoExaminador.sim;
                                                                                      });
                                                                                    },
                                                                                    corDoBotao: terceiraRespostaDoExaminador == condicaoExaminador.sim ? kPurpleColor : kCorInativa,
                                                                                    botaoTexto: 'Sim',
                                                                                    altura: screenHeight * alturaDoBotao,
                                                                                  ),
                                                                                ),
                                                                                //
                                                                                //
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  ///
                                                                  ///

                                                                  SizedBox(
                                                                    height:
                                                                        screenHeight *
                                                                            .1,
                                                                  ),
                                                                ],
                                                              )
                                                            //
                                                            // Aqui ele verifica
                                                            : Container(
                                                                child: categoriaEspecial ==
                                                                            'dia da semana' ||
                                                                        categoriaEspecial ==
                                                                            'mes atual'
                                                                    ? Container(
                                                                        child: categoriaEspecial ==
                                                                                'dia da semana'
                                                                            ? Column(
                                                                                children: [
                                                                                  SizedBox(height: screenHeight * .2),
                                                                                  ChoiceList(
                                                                                    listItems: weekDays,
                                                                                    initialValue: weekDays.first,
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * .155),
                                                                                ],
                                                                              )
                                                                            : Column(
                                                                                children: [
                                                                                  SizedBox(height: screenHeight * .2),
                                                                                  ChoiceList(
                                                                                    listItems: months,
                                                                                    initialValue: months.first,
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * .155),
                                                                                ],
                                                                              ))
                                                                    //
                                                                    // Se não for nenhuma das outras condições, quer dizer que
                                                                    // a resposta é só uma caixa de texto normal
                                                                    : Container(
                                                                        child: categoriaEspecial ==
                                                                                'dia do mes'
                                                                            ? Column(
                                                                                children: [
                                                                                  SizedBox(height: screenHeight * .05),
                                                                                  Text(
                                                                                    'Selecione o dia informado pelo paciente',
                                                                                    style: TextStyle(fontSize: _maxValue(value: screenHeight * .045, max: 28)),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * .02),
                                                                                  Center(
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(color: Colors.black, width: 2),
                                                                                      ),
                                                                                      height: _maxValue(value: boxHeight, max: 350),
                                                                                      width: boxWidth,
                                                                                      child: categoriaEspecial == 'dia do mes'
                                                                                          ? Container(
                                                                                              child: DaySelect(),
                                                                                            )
                                                                                          : Container(),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * .05),
                                                                                ],
                                                                              )
                                                                            //
                                                                            //
                                                                            : Container(
                                                                                child: categoriaEspecial == 'hora'
                                                                                    ? Column(
                                                                                        children: [
                                                                                          SizedBox(height: screenHeight * .07),
                                                                                          Text(
                                                                                            'Digite a hora informada pelo paciente',
                                                                                            style: TextStyle(fontSize: _maxValue(value: screenHeight * .045, max: 28)),
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(left: 50),
                                                                                                  child: respostaMeem(label: 'Hora', controlador: controladorDaBarraDeTexto, altura: screenHeight * alturaDaCaixaDeTexto, labelSize: labelsize, cursorSize: cursorsize, validador: _primeiro_textfield_formkey, isNumber: true, centerLabel: true),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                ' : ',
                                                                                                style: TextStyle(fontSize: screenHeight * .08),
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(right: 50),
                                                                                                  child: respostaMeem(label: 'Minuto', controlador: segundoControladorDeTexto, altura: screenHeight * alturaDaCaixaDeTexto, labelSize: _maxValue(value: labelsize, max: 22), cursorSize: cursorsize, validador: _segundo_textfield_formkey, isNumber: true, centerLabel: true),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(height: screenHeight * .2),
                                                                                            ],
                                                                                          ),
                                                                                          Container(
                                                                                            height: _maxValue(value: screenHeight * .35, max: 235),
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              boxShadow: [
                                                                                                BoxShadow(
                                                                                                  color: Colors.grey,
                                                                                                  spreadRadius: 2,
                                                                                                  blurRadius: 8,
                                                                                                  offset: Offset(1, 4),
                                                                                                ),
                                                                                              ],
                                                                                              borderRadius: BorderRadius.circular(25),
                                                                                              border: Border.all(color: Colors.black, width: 2.5),
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(11.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                children: [
                                                                                                  textoDeConfirmacao('O paciente conseguiu informar a hora corretamente?', screenHeight * tamanhoDoTexto),
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        height: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                                        width: size.width * larguraDoBotao,
                                                                                                        child: BotaoPadrao(
                                                                                                          altura: _maxValue(value: screenHeight * alturaDoBotao, max: 100),
                                                                                                          corDoBotao: respostaDoExaminador == condicaoExaminador.nao ? kPurpleColor : kCorInativa,
                                                                                                          botaoTexto: 'Não',
                                                                                                          aoPressionar: () {
                                                                                                            setState(() {
                                                                                                              respostaDoExaminador = condicaoExaminador.nao;
                                                                                                            });
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        height: screenHeight * alturaDoBotao,
                                                                                                        width: size.width * larguraDoBotao,
                                                                                                        child: BotaoPadrao(
                                                                                                          aoPressionar: () {
                                                                                                            setState(() {
                                                                                                              respostaDoExaminador = condicaoExaminador.sim;
                                                                                                            });
                                                                                                          },
                                                                                                          corDoBotao: respostaDoExaminador == condicaoExaminador.sim ? kPurpleColor : kCorInativa,
                                                                                                          botaoTexto: 'Sim',
                                                                                                          altura: screenHeight * alturaDoBotao,
                                                                                                        ),
                                                                                                      ),
                                                                                                      //
                                                                                                      //
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(height: screenHeight * .03),
                                                                                        ],
                                                                                      )
                                                                                    : Column(
                                                                                        //
                                                                                        // Então ele retorna apenas um textformfield para a resposta
                                                                                        children: [
                                                                                          SizedBox(height: screenHeight * .2),
                                                                                          respostaMeem(
                                                                                            label: 'Resposta do Paciente',
                                                                                            controlador: controladorDaBarraDeTexto,
                                                                                            altura: screenHeight * alturaDaCaixaDeTexto,
                                                                                            labelSize: labelsize,
                                                                                            cursorSize: cursorsize,
                                                                                            validador: _primeiro_textfield_formkey,
                                                                                            isNumber: categoriaEspecial == 'ano atual' ? true : false,
                                                                                          ),
                                                                                          SizedBox(height: screenHeight * .15),
                                                                                        ],
                                                                                      ),
                                                                              ),
                                                                      ),
                                                              )),
                                          ),
                                  ),
                      ),
              ),
            ),

            // Aqui é chamado o botão que confirma a resposta e avança
            // para a próxima pergunta
            //
            // padding
            Padding(
              padding: const EdgeInsets.all(kMargemDosWidgets),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Expanded(
                    child: BotaoPadrao(
                      corDoBotao: perguntas.numeroDaPerguntaAtual < 1
                          ? kCorInativa
                          : kPurpleColor,
                      altura: screenHeight * .11,
                      max_height: 40,
                      botaoTexto: 'Voltar',
                      aoPressionar: perguntas.numeroDaPerguntaAtual < 1
                          ? () {}
                          : () {
                              setState(() {
                                perguntas.perguntaAnterior();
                                categoriaAtual =
                                    perguntas.obterCategoriaDaPergunta();
                                //
                                categoriaEspecial =
                                    perguntas.obterCategoriaEspecial();
                                atribuirCores();
                                resposta = perguntas.obterResposta();
                                listaDeRespostasDoExaminador.removeLast();
                                //
                                // removendo o ultimo item da lista de respostas
                                respostasDoPaciente.removerResposta();

                                respostaDoExaminador = condicaoExaminador.nulo;
                                segundaRespostaDoExaminador =
                                    condicaoExaminador.nulo;
                                terceiraRespostaDoExaminador =
                                    condicaoExaminador.nulo;
                                //
                                //
                                controladorDaBarraDeTexto =
                                    TextEditingController();
                                segundoControladorDeTexto =
                                    TextEditingController();
                                terceiroControladorDeTexto =
                                    TextEditingController();
                                //
                                //
                                fraseDoPaciente = '';
                                day_of_month = '';
                              });
                            },
                    ),
                  ),
                  SizedBox(width: size.width * .015),
                  Expanded(
                    child: BotaoPadrao(
                      corDoBotao: Colors.white,
                      altura: screenHeight * .11,
                      max_height: 32,
                      botaoTexto: 'Confirmar',
                      aoPressionar: () {
                        //
                        //
                        //

                        // Quando o botão é pressionado,
                        //ele chama a função que confere a resposta
                        if (categoriaEspecial == 'dia da semana' ||
                            categoriaEspecial == 'dia do mes' ||
                            categoriaEspecial == 'mes atual' ||
                            categoriaEspecial == '3 acões' ||
                            categoriaEspecial == 'executar comando' ||
                            categoriaEspecial == 'desenho' ||
                            categoriaEspecial == 'endereço') {
                          apertarConfirmar();
                        } else {
                          if (categoriaAtual == 'Memória Imediata' ||
                              categoriaAtual == 'Memória Recente') {
                            if (_primeiro_textfield_formkey.currentState!
                                    .validate() &&
                                _segundo_textfield_formkey.currentState!
                                    .validate() &&
                                _terceiro_textfield_formkey.currentState!
                                    .validate()) {
                              apertarConfirmar();
                            }
                          } else if (categoriaEspecial == 'nomear objetos' ||
                              categoriaAtual == 'hora') {
                            if (_segundo_textfield_formkey.currentState!
                                    .validate() &&
                                _primeiro_textfield_formkey.currentState!
                                    .validate()) {
                              apertarConfirmar();
                            }
                          } else if (categoriaEspecial == 'escrever frase') {
                            if (_primeiro_textfield_formkey.currentState!
                                .validate()) {
                              apertarConfirmar();
                            }
                          } else if (categoriaEspecial == 'repetir frase') {
                            if (respostaDoExaminador ==
                                condicaoExaminador.nao) {
                              if (_primeiro_textfield_formkey.currentState!
                                  .validate()) {
                                apertarConfirmar();
                              }
                            } else {
                              apertarConfirmar();
                            }
                          } else {
                            if (_primeiro_textfield_formkey.currentState!
                                .validate()) {
                              apertarConfirmar();
                            }
                          }
                        }

                        // else
                        //  apertarConfirmar();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textoDeConfirmacao(String texto, double textSize) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: _maxValue(value: textSize, max: 24),
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  //
//
}

//
Widget containerActions({
  required String texto,
  required int numeroDaAcao,
  // required Row linha,
}) {
  return Container(
    height: screenHeight * .35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: Colors.black, width: 3),
    ),
    child: Padding(
      padding: const EdgeInsets.all(11.0),
    ),
  );
}
//

// Widget da caixa de texto onde é feita a resposta
Widget respostaMeem(
    {required String label,
    required TextEditingController controlador,
    required double altura,
    required double labelSize,
    required double cursorSize,
    bool isNumber = false,
    bool centerLabel = false,
    required GlobalKey<FormState> validador}) {
  return Form(
    key: validador,
    child: Container(
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      //height: altura,
      child: TextFormField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          cursorHeight: cursorSize,
          cursorColor: kCorDoTema,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: label,
            labelStyle: TextStyle(
              color: kPurpleColor,
              fontSize: labelSize,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          controller: controlador,
          textAlign: centerLabel == true ? TextAlign.center : TextAlign.start,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Você deve preencher este campo!';
            }
          }),
    ),
  );
}

//////////////////////////////////////////
/////////////////////////////////////////
// Esse widget é onde ficam as perguntas do exame
Widget containerDasRespostas(Widget filhoContainer, double altura) {
  return Container(
    height: altura,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: corDoExame,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 8,
          offset: Offset(1, 5),
        ),
      ],
    ),
    child: filhoContainer,
  );
}

//////////////////////////////////////////
/////////////////////////////////////////
///
Widget botaoDeSimOuNao(
    {required Function aoApertar, required String texto, required Color cor}) {
  return Container(
    width: 120,
    child: BotaoPadrao(
      corDoBotao: cor,
      botaoTexto: texto,
      aoPressionar: () {
        aoApertar;
      },
    ),
  );
}

///
///
///
///
///

// Pagina onde o paciente irá fazer o desenho da última pergunta do MEEM
class PaginaDoDesenho extends StatefulWidget {
  const PaginaDoDesenho({Key? key}) : super(key: key);

  @override
  _PaginaDoDesenhoState createState() => _PaginaDoDesenhoState();
}

class _PaginaDoDesenhoState extends State<PaginaDoDesenho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
