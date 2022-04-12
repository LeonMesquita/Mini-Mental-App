import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/dados_do_paciente.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/get_position.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/perguntas.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';

class SelecionarExame extends StatelessWidget {
  const SelecionarExame({Key? key}) : super(key: key);
  double _maxValue({required double value, required double max}) {
    if (value < max) {
      return value;
    } else
      return max;
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    var boxHeight = screenHeight * .45;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
        ),
        child: Center(
          child: FutureBuilder(
            future: updatePosition(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: size.width * .1,
                    height: screenHeight * .1,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Container(
                      height: boxHeight,
                      width: _maxValue(value: size.width * .7, max: 350),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 4,
                              //offset: Offset(1, 5),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.warning,
                            size: boxHeight * .35,
                            color: Colors.yellow.shade700,
                          ),
                          Text(
                            'Você deve permitir o acesso à localização!',
                            style: TextStyle(
                                fontSize: boxHeight * .09,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelecionarExame(),
                                ),
                              );
                            },
                            child: Text(
                              'Confirmar',
                              style: TextStyle(
                                  fontSize: boxHeight * .1,
                                  color: Color(0xFF5692ce6),
                                  fontWeight: FontWeight.w900),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(kBackgroundImage),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // As opções dos exames serão mostradas aqui
                          Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Text(
                              'Mini-Exame do Estado Mental',
                              style: TextStyle(
                                fontSize:
                                    _maxValue(value: boxHeight * .3, max: 50),
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Image(
                            image: AssetImage(kLogoImage),
                            height:
                                _maxValue(value: screenHeight * .55, max: 400),
                          ),
                          // SizedBox(height: screenHeight * .1),
                          Container(
                            height:
                                _maxValue(value: screenHeight * .2, max: 90),
                            margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DadosDoPaciente(),
                                  ),
                                );
                              },
                              child: Text('INICIAR EXAME',
                                  style: TextStyle(
                                    fontSize: _maxValue(
                                        value: boxHeight * .3, max: 40),
                                    fontWeight: FontWeight.w900,
                                    color: kPurpleColor,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}

/*


*/
