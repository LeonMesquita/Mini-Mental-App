import 'package:flutter_application_1/Testes Cognitivos/MEEM/meem.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/dados_do_paciente.dart';

class Paciente {
  String? nome = '';
  int? idade;
  int pontos_meem;
  String? escolaridade;
  String? _condicaoMental;
  escolaridadeDoPaciente enumDaEscolaridade = escolaridadeDoPaciente.nulo;

  Paciente({
    this.nome,
    this.escolaridade,
    this.idade,
    this.pontos_meem = 0,
  });

  void atribuirNome(n) {
    nome = n;
  }

  void atribuirIdade(i) {
    idade = i;
  }

  void atribuirEscolaridade(e, enu) {
    escolaridade = e;
    enumDaEscolaridade = enu;
  }

  void atribuirPontosMeem() {
    pontos_meem++;
  }

  void atribuirCondicaoMental(c) {
    _condicaoMental = c;
  }

  String retornarCondicaoMental() {
    return _condicaoMental!;
  }

  void resetarAtributos() {
    pontos_meem = 0;
    _condicaoMental = '';
  }
}
