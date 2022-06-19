import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/meem.dart';

int calcResult({newPatient}) {
  marcadorDePontos = 0;
  newPatient.pontos_meem = 0;
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
        newPatient.atribuirPontosMeem();
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
            newPatient.atribuirPontosMeem();
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
            newPatient.atribuirPontosMeem();
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
            newPatient.atribuirPontosMeem();
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
        newPatient.atribuirPontosMeem();
        marcadorDePontos++;
      }
    }
    //
    //

  }

  return marcadorDePontos;
}
