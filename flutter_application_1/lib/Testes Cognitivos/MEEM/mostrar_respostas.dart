import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/botaopadrao.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';
import 'meem.dart';

class MostrarRespostas extends StatelessWidget {
  const MostrarRespostas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    double buttonHeight = screenHeight * .12;
    double textHeight = buttonHeight * .7;
    return Scaffold(
        body: Container(
      height: size.height * 1,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * .12),
            Text(
              'Lista de perguntas e respostas do Paciente',
              style: TextStyle(
                fontSize: screenHeight * .045,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * .05),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: respostasDoPaciente.retornarPergunta() is String
                  //
                  // Aqui ele verifica se a pergunta é apenas uma string normal
                  ? respostasDoPaciente.mostrarRespostas()

                  //
                  // Se a pergunta não for uma string, significa que é um widget
                  // Nesse caso ele exibe o widget na tela
                  : respostasDoPaciente.retornarPergunta(),
            ),

            //
            SizedBox(height: screenHeight * .09),

            Padding(
              padding: const EdgeInsets.all(kMargemDosWidgets),
              child: Container(
                height: buttonHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kCorInativa,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                        fontSize: textHeight,
                        fontWeight: FontWeight.w900,
                        color: kPurpleColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
