import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/meem_functions/calc_result.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/meem_widgets/confirmation_card.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/selecionar_exame.dart';
import 'package:flutter_application_1/Widgets/choice_list.dart';
import 'package:flutter_application_1/Widgets/day_select.dart';
import 'package:flutter_application_1/Widgets/remove_accents.dart';
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
                  marcadorDePontos = calcResult(newPatient: novoPaciente);
                  //calcularResultado();
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
      String str1 =
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft();
      String str2 =
          segundoControladorDeTexto.text.toLowerCase().trimRight().trimLeft();
      String str3 =
          terceiroControladorDeTexto.text.toLowerCase().trimRight().trimLeft();
      reserva.add(removeAccents(str1));
      reserva.add(removeAccents(str2));
      reserva.add(removeAccents(str3));
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
      String obj1 = removeAccents(
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft());

      String obj2 = removeAccents(
          segundoControladorDeTexto.text.toLowerCase().trimRight().trimLeft());
      reserva.add(obj1);
      reserva.add(obj2);
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
      String str = removeAccents(
          controladorDaBarraDeTexto.text.toLowerCase().trimRight().trimLeft());
      listaDeRespostasDoExaminador.add(str);
      enunciadoDaPergunta = perguntas.obterEnuncuadoDasPerguntas();

      if (str == resposta) {
        esta_correto = true;
      } else {
        esta_correto = false;
      }
      //
      //
      // preenchendo a lista de respostas do paciente
      respostasDoPaciente.preencherListaDeRespostas(
        perg: enunciadoDaPergunta,
        resp: str,
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
    var appbar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
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
            Alert(
              context: context,
              type: AlertType.warning,
              title: 'Tem certeza de que deseja voltar para a tela inicial?',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelecionarExame(),
                        ),
                      );
                    });
                  },
                  width: 120,
                ),
              ],
            ).show();
          },
          icon: Icon(Icons.home),
        ),
      ],
    );
    //
    var size = MediaQuery.of(context).size;
    var appbarHeight =
        appbar.preferredSize.height + MediaQuery.of(context).padding.top;
    var screenHeight = size.height - appbarHeight;
    //
    //
    var imageSize = size.height * .05;

    perguntas.setarTamanho(imageSize);

    //
    //

    //
    //

    var boxHeight = screenHeight * daySize;
    var boxWidth = size.width * dayWidth;
    //
    //
    var labelsize = screenHeight * .03;
    var cursorsize = screenHeight * .04;
    return Scaffold(
      extendBodyBehindAppBar: true,

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
      body: Container(
        height: size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 90, left: kMargemDosWidgets, right: kMargemDosWidgets),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // Aqui é chamado o container onde ficam as perguntas
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    // color: Colors.red,
                    height: screenHeight * .55,
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
                ),
                //SizedBox(height: 90),
                //
                // Aqui é verificado se a pergunta é do tipo memória imediata ou memória recente
                // Ambas tem a mesma resposta
                if (categoriaAtual == 'Memória Imediata' ||
                    categoriaAtual == 'Memória Recente')
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //
                        // Caso seja verdadeiro, é retornado 3 TextFormFields
                        // Um para cada palavra

                        children: [
                          //SizedBox(height: screenHeight * .07),
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
                  ),
                //
                //
                if (resposta is List && categoriaAtual == 'Linguagem')
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      respostaMeem(
                          label: 'Primeiro objeto',
                          controlador: controladorDaBarraDeTexto,
                          altura: screenHeight * alturaDaCaixaDeTexto,
                          labelSize: labelsize,
                          cursorSize: cursorsize,
                          validador: _primeiro_textfield_formkey),
                      SizedBox(height: screenHeight * .07),
                      respostaMeem(
                          label: 'Segundo objeto',
                          controlador: segundoControladorDeTexto,
                          altura: screenHeight * alturaDaCaixaDeTexto,
                          labelSize: labelsize,
                          cursorSize: cursorsize,
                          validador: _segundo_textfield_formkey),
                      SizedBox(height: screenHeight * .085),
                    ],
                  ),

                if (resposta == null)
                  Column(
                    children: [
                      ConfirmationCard(
                        cartText: categoriaEspecial == 'endereço'
                            ? 'O paciente conseguiu informar o endereço corretamente?'
                            : 'O paciente conseguiu executar o comando corretamente?',
                        buttonYesColor:
                            respostaDoExaminador == condicaoExaminador.sim
                                ? kCorAtiva
                                : kPurpleColor,
                        buttonNoColor:
                            respostaDoExaminador == condicaoExaminador.nao
                                ? kCorAtiva
                                : kPurpleColor,
                        onPressNo: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.nao;
                          });
                        },
                        onPressYes: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.sim;
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * .08),
                    ],
                  ),
                //
                //
                if (resposta == 'Frase do Paciente')
                  Column(
                    children: [
                      ConfirmationCard(
                        cartText: categoriaEspecial == 'repetir frase'
                            ? 'O paciente conseguiu repetir a frase corretamente?'
                            : 'O paciente conseguiu escrever uma frase corretamente?',
                        buttonYesColor:
                            respostaDoExaminador == condicaoExaminador.sim
                                ? kCorAtiva
                                : kPurpleColor,
                        buttonNoColor:
                            respostaDoExaminador == condicaoExaminador.nao
                                ? kCorAtiva
                                : kPurpleColor,
                        onPressNo: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.nao;
                          });
                        },
                        onPressYes: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.sim;
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * .05),
                      //

                      //
                      categoriaEspecial == 'repetir frase' &&
                              respostaDoExaminador != condicaoExaminador.nao
                          ? SizedBox(height: screenHeight * .00)
                          : respostaMeem(
                              label: categoriaEspecial == 'repetir frase'
                                  ? 'Resposta do Paciente'
                                  : 'Frase do Paciente',
                              controlador: controladorDaBarraDeTexto,
                              altura: screenHeight * alturaDaCaixaDeTexto,
                              labelSize: labelsize,
                              cursorSize: cursorsize,
                              validador: _primeiro_textfield_formkey),
                      SizedBox(height: screenHeight * .03),
                    ],
                  ),
                //
                //
                if (categoriaEspecial == "3 acões")
                  Column(
                    children: [
                      // SizedBox(
                      //  height:
                      //     screenHeight *
                      //        .1),
                      ConfirmationCard(
                        cartText: textoDasTresAcoes[0],
                        buttonYesColor:
                            respostaDoExaminador == condicaoExaminador.sim
                                ? kCorAtiva
                                : kPurpleColor,
                        buttonNoColor:
                            respostaDoExaminador == condicaoExaminador.nao
                                ? kCorAtiva
                                : kPurpleColor,
                        onPressNo: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.nao;
                          });
                        },
                        onPressYes: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.sim;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ConfirmationCard(
                          cartText: textoDasTresAcoes[1],
                          buttonYesColor: segundaRespostaDoExaminador ==
                                  condicaoExaminador.sim
                              ? kCorAtiva
                              : kPurpleColor,
                          buttonNoColor: segundaRespostaDoExaminador ==
                                  condicaoExaminador.nao
                              ? kCorAtiva
                              : kPurpleColor,
                          onPressNo: () {
                            setState(() {
                              segundaRespostaDoExaminador =
                                  condicaoExaminador.nao;
                            });
                          },
                          onPressYes: () {
                            setState(() {
                              segundaRespostaDoExaminador =
                                  condicaoExaminador.sim;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ConfirmationCard(
                          cartText: textoDasTresAcoes[2],
                          buttonYesColor: terceiraRespostaDoExaminador ==
                                  condicaoExaminador.sim
                              ? kCorAtiva
                              : kPurpleColor,
                          buttonNoColor: terceiraRespostaDoExaminador ==
                                  condicaoExaminador.nao
                              ? kCorAtiva
                              : kPurpleColor,
                          onPressNo: () {
                            setState(() {
                              terceiraRespostaDoExaminador =
                                  condicaoExaminador.nao;
                            });
                          },
                          onPressYes: () {
                            setState(() {
                              terceiraRespostaDoExaminador =
                                  condicaoExaminador.sim;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * .1,
                      ),
                    ],
                  ),
                //
                //
                if (categoriaEspecial == 'dia da semana' ||
                    categoriaEspecial == 'mes atual')
                  Container(
                    child: categoriaEspecial == 'dia da semana'
                        ? Column(
                            children: [
                              // SizedBox(height: screenHeight * .2),
                              ChoiceList(
                                listItems: weekDays,
                                initialValue: weekDays.first,
                              ),
                              SizedBox(
                                  height: _maxValue(
                                      value: screenHeight * .22, max: 125)),
                            ],
                          )
                        : Column(
                            children: [
                              // SizedBox(height: screenHeight * .27),
                              ChoiceList(
                                listItems: months,
                                initialValue: months.first,
                              ),
                              SizedBox(
                                  height: _maxValue(
                                      value: screenHeight * .22, max: 125)),
                            ],
                          ),
                  ),
                //
                //
                if (categoriaEspecial == "dia do mes")
                  Column(
                    children: [
                      // SizedBox(height: screenHeight * .05),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Selecione o dia informado pelo paciente',
                          style: TextStyle(
                            fontSize:
                                _maxValue(value: screenHeight * .045, max: 25),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      Center(
                        child: categoriaEspecial == 'dia do mes'
                            ? DaySelect()
                            : Container(),
                      ),
                      SizedBox(height: screenHeight * .05),
                    ],
                  ),
                //
                //
                if (categoriaEspecial == "hora")
                  Column(
                    children: [
                      // SizedBox(height: screenHeight * .07),
                      Text(
                        'Digite a hora informada pelo paciente',
                        style: TextStyle(
                            fontSize:
                                _maxValue(value: screenHeight * .045, max: 28),
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: respostaMeem(
                                  label: 'Hora',
                                  controlador: controladorDaBarraDeTexto,
                                  altura: screenHeight * alturaDaCaixaDeTexto,
                                  labelSize: labelsize,
                                  cursorSize: cursorsize,
                                  validador: _primeiro_textfield_formkey,
                                  isNumber: true,
                                  centerLabel: true),
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                              fontSize: screenHeight * .08,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: respostaMeem(
                                  label: 'Minuto',
                                  controlador: segundoControladorDeTexto,
                                  altura: screenHeight * alturaDaCaixaDeTexto,
                                  labelSize:
                                      _maxValue(value: labelsize, max: 22),
                                  cursorSize: cursorsize,
                                  validador: _segundo_textfield_formkey,
                                  isNumber: true,
                                  centerLabel: true),
                            ),
                          ),
                          SizedBox(height: screenHeight * .2),
                        ],
                      ),
                      ConfirmationCard(
                        cartText:
                            'O paciente conseguiu informar a hora corretamente?',
                        buttonYesColor:
                            respostaDoExaminador == condicaoExaminador.sim
                                ? kCorAtiva
                                : kPurpleColor,
                        buttonNoColor:
                            respostaDoExaminador == condicaoExaminador.nao
                                ? kCorAtiva
                                : kPurpleColor,
                        onPressNo: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.nao;
                          });
                        },
                        onPressYes: () {
                          setState(() {
                            respostaDoExaminador = condicaoExaminador.sim;
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * .05),
                    ],
                  ),
                //
                //
                if (categoriaEspecial == 'resposta comum')
                  Column(
                    //
                    // Então ele retorna apenas um textformfield para a resposta
                    children: [
                      //SizedBox(height: screenHeight * .3),
                      respostaMeem(
                        label: 'Resposta do Paciente',
                        controlador: controladorDaBarraDeTexto,
                        altura: screenHeight * alturaDaCaixaDeTexto,
                        labelSize: labelsize,
                        cursorSize: cursorsize,
                        validador: _primeiro_textfield_formkey,
                        isNumber:
                            categoriaEspecial == 'ano atual' ? true : false,
                      ),
                      SizedBox(
                          height:
                              _maxValue(value: screenHeight * .2, max: 125)),
                    ],
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
                              : kCorInativa,
                          altura: screenHeight * .11,
                          max_height: 32,
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

                                    respostaDoExaminador =
                                        condicaoExaminador.nulo;
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

                            /*

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
                              } else if (categoriaEspecial ==
                                      'nomear objetos' ||
                                  categoriaAtual == 'hora') {
                                if (_segundo_textfield_formkey.currentState!
                                        .validate() &&
                                    _primeiro_textfield_formkey.currentState!
                                        .validate()) {
                                  apertarConfirmar();
                                }
                              } else if (categoriaEspecial ==
                                  'escrever frase') {
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
                            */

                            //else
                            apertarConfirmar();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textoDeConfirmacao(String texto, double textSize) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: _maxValue(value: textSize, max: 24),
        color: kPurpleColor,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

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
            hintText: label,
            hintStyle: TextStyle(
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
