import 'dart:math';

List<String> listaDePalavras = [
  'vaso',
  'carro',
  'pedra',
  'casa',
  'gato',
  'bola',
  'peixe',
  'moto',
  'homem',
  'rua',
  'tigre',
  'copo',
  'rato',
  'rio',
  'mesa',
];

List<String> selectedWords = [];

List<String> gerarPalavrasAleatorias() {
  selectedWords = [];
  List<String> lista = [];
  // Pegando uma palavra em uma posição aleatória da lista de palavras
  while (selectedWords.length < 3) {
    String temp = listaDePalavras[Random().nextInt(listaDePalavras.length)];
    if (!selectedWords.contains(temp)) {
      selectedWords.add(temp);
    }
  }
  return selectedWords;
}
