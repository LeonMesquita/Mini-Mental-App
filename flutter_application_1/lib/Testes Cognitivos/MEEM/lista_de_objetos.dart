import 'dart:math';

class CorpoDaImagem {
  String imagePath;
  String imageName;
  CorpoDaImagem({required this.imageName, required this.imagePath});
}

List<CorpoDaImagem> bancoDeImagens = [
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/caneta.jpg', imageName: 'caneta'),
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/relogio.jpg', imageName: 'relógio'),
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/carro.jpg', imageName: 'carro'),
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/livro.jpg', imageName: 'livro'),
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/bicicleta.jpg',
      imageName: 'bicicleta'),
  CorpoDaImagem(
      imagePath: 'assets/imagens/objetos/martelo.jpg', imageName: 'martelo'),
];

CorpoDaImagem obj1 = CorpoDaImagem(imagePath: '', imageName: '');
CorpoDaImagem obj2 = CorpoDaImagem(imagePath: '', imageName: '');

CorpoDaImagem gerarObjeto1() {
  obj1 = CorpoDaImagem(imagePath: '', imageName: '');

  do {
    obj1 = bancoDeImagens[Random().nextInt(bancoDeImagens.length)];
  } while (obj1.imageName == obj2.imageName);
  return obj1;
}

CorpoDaImagem gerarObjeto2() {
  obj2 = CorpoDaImagem(imagePath: '', imageName: '');

  do {
    obj2 = bancoDeImagens[Random().nextInt(bancoDeImagens.length)];
  } while (obj1.imageName == obj2.imageName);
  return obj2;
}
