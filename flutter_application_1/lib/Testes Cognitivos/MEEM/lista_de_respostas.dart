import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';

class CorpoDaResposta {
  dynamic pergunta;
  dynamic resposta;
  bool is_correct;
  List<bool> list_is_correct;

  CorpoDaResposta(
      {required this.pergunta,
      required this.resposta,
      this.is_correct = true,
      required this.list_is_correct});
}

class ListaDeRespostas {
  List<CorpoDaResposta> lista_resp = [
    //corpoDaResposta[pergunta] = 'jooj',
  ];

  void preencherListaDeRespostas({perg, resp, correct, list_correct}) {
    lista_resp.add(
      CorpoDaResposta(
          pergunta: perg,
          resposta: resp,
          is_correct: correct,
          list_is_correct: list_correct),
    );
  }

  void removerResposta() {
    lista_resp.removeLast();
  }

  dynamic mostrarRespostas() {
    return Column(
      children: [
        formatoDasRespostas(
          lista_resp[0].pergunta,
          lista_resp[0].resposta,
          lista_resp[0].is_correct ? Colors.green : Colors.red,
          lista_resp[0].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[1].pergunta,
          lista_resp[1].resposta,
          lista_resp[1].is_correct ? Colors.green : Colors.red,
          lista_resp[1].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[2].pergunta,
          lista_resp[2].resposta,
          lista_resp[2].is_correct ? Colors.green : Colors.red,
          lista_resp[2].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[3].pergunta,
          lista_resp[3].resposta,
          lista_resp[3].is_correct ? Colors.green : Colors.red,
          lista_resp[3].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[4].pergunta,
          lista_resp[4].resposta,
          lista_resp[4].is_correct ? Colors.green : Colors.red,
          lista_resp[4].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[5].pergunta,
          lista_resp[5].resposta,
          lista_resp[5].is_correct ? Colors.green : Colors.red,
          lista_resp[5].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[6].pergunta,
          lista_resp[6].resposta,
          lista_resp[6].is_correct ? Colors.green : Colors.red,
          lista_resp[6].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[7].pergunta,
          lista_resp[7].resposta,
          lista_resp[7].is_correct ? Colors.green : Colors.red,
          lista_resp[7].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[8].pergunta,
          lista_resp[8].resposta,
          lista_resp[8].is_correct ? Colors.green : Colors.red,
          lista_resp[8].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[9].pergunta,
          lista_resp[9].resposta,
          lista_resp[9].is_correct ? Colors.green : Colors.red,
          lista_resp[9].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[10].pergunta,
          lista_resp[10].resposta,
          lista_resp[10].is_correct ? Colors.green : Colors.red,
          lista_resp[10].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[11].pergunta,
          lista_resp[11].resposta,
          lista_resp[11].is_correct ? Colors.green : Colors.red,
          lista_resp[11].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[12].pergunta,
          lista_resp[12].resposta,
          lista_resp[12].is_correct ? Colors.green : Colors.red,
          lista_resp[12].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[13].pergunta,
          lista_resp[13].resposta,
          lista_resp[13].is_correct ? Colors.green : Colors.red,
          lista_resp[13].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[14].pergunta,
          lista_resp[14].resposta,
          lista_resp[14].is_correct ? Colors.green : Colors.red,
          lista_resp[14].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[15].pergunta,
          lista_resp[15].resposta,
          lista_resp[15].is_correct ? Colors.green : Colors.red,
          lista_resp[15].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[16].pergunta,
          lista_resp[16].resposta,
          lista_resp[16].is_correct ? Colors.green : Colors.red,
          lista_resp[16].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[17].pergunta,
          lista_resp[17].resposta,
          lista_resp[17].is_correct ? Colors.green : Colors.red,
          lista_resp[17].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[18].pergunta,
          lista_resp[18].resposta,
          lista_resp[18].is_correct ? Colors.green : Colors.red,
          lista_resp[18].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[19].pergunta,
          lista_resp[19].resposta,
          lista_resp[19].is_correct ? Colors.green : Colors.red,
          lista_resp[19].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[20].pergunta,
          lista_resp[20].resposta,
          lista_resp[20].is_correct ? Colors.green : Colors.red,
          lista_resp[20].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[21].pergunta,
          lista_resp[21].resposta,
          lista_resp[21].is_correct ? Colors.green : Colors.red,
          lista_resp[21].list_is_correct,
        ),
        formatoDasRespostas(
          lista_resp[22].pergunta,
          lista_resp[22].resposta,
          lista_resp[22].is_correct ? Colors.green : Colors.red,
          lista_resp[22].list_is_correct,
        ),
      ],
    );

    //Text(lista_resp[0].pergunta + ' -- ' + lista_resp[0].resposta);
  }

  dynamic retornarPergunta() {
    return lista_resp[0].pergunta;
  }

  dynamic retornarResposta() {
    return lista_resp[0].pergunta;
  }

  Widget formatoDasRespostas(pergunta, resposta, corDaResposta, lista_bool) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: resposta is List
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pergunta: ' + pergunta,
                      style: kEstiloDasRespostas,
                    ),
                    Text(
                      'Resposta(s): ',
                      style: kEstiloDasRespostas,
                    ),
                    resposta.length == 3
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    resposta[0],
                                    style: TextStyle(
                                        color: lista_bool[0]
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                      lista_bool[0] == true
                                          ? Icons.done
                                          : Icons.close,
                                      color: lista_bool[0] == true
                                          ? Colors.green
                                          : Colors.red)
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    resposta[1],
                                    style: TextStyle(
                                        color: lista_bool[1]
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                      lista_bool[1] == true
                                          ? Icons.done
                                          : Icons.close,
                                      color: lista_bool[1] == true
                                          ? Colors.green
                                          : Colors.red)
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    resposta[2],
                                    style: TextStyle(
                                        color: lista_bool[2]
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                      lista_bool[2] == true
                                          ? Icons.done
                                          : Icons.close,
                                      color: lista_bool[2] == true
                                          ? Colors.green
                                          : Colors.red)
                                ],
                              )
                            ],
                          )
                        : Container(
                            child: resposta.length == 4
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            resposta[0] + ':' + resposta[1],
                                            style: TextStyle(
                                                color: corDaResposta,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                              corDaResposta == Colors.green
                                                  ? Icons.done
                                                  : Icons.close,
                                              color:
                                                  corDaResposta == Colors.green
                                                      ? Colors.green
                                                      : Colors.red)
                                        ],
                                      ),
                                    ],
                                  )
                                //
                                //
                                //
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            resposta[0],
                                            style: TextStyle(
                                                color: lista_bool[0]
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                              lista_bool[0] == true
                                                  ? Icons.done
                                                  : Icons.close,
                                              color: lista_bool[0] == true
                                                  ? Colors.green
                                                  : Colors.red)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            resposta[1],
                                            style: TextStyle(
                                                color: lista_bool[1]
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                              lista_bool[0] == true
                                                  ? Icons.done
                                                  : Icons.close,
                                              color: lista_bool[0] == true
                                                  ? Colors.green
                                                  : Colors.red)
                                        ],
                                      ),
                                    ],
                                  ))
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pergunta: ' + pergunta,
                      style: kEstiloDasRespostas,
                    ),
                    Row(
                      children: [
                        Text(
                          'Resposta(s): ',
                          style: kEstiloDasRespostas,
                        ),
                        Text(
                          resposta,
                          style: TextStyle(
                              color: corDaResposta,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                            corDaResposta == Colors.green
                                ? Icons.done
                                : Icons.close,
                            color: corDaResposta == Colors.green
                                ? Colors.green
                                : Colors.red)
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

double _maxValue({required double value, required double max}) {
  if (value < max) {
    return value;
  } else
    return max;
}

var kEstiloDasRespostas = TextStyle(fontSize: 20);
