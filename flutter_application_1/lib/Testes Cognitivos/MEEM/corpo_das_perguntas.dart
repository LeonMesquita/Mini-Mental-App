class PerguntasEscritas {
  dynamic questao;
  String enunciado;
  dynamic respostaDaQuestao;
  String categoriaDaPergunta;
  String categoriaEspecial;
  PerguntasEscritas(
      {required this.questao,
      required this.respostaDaQuestao,
      this.categoriaDaPergunta = '',
      this.categoriaEspecial = '',
      this.enunciado = ''});
}
