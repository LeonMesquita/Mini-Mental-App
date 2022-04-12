import 'package:flutter/material.dart';

String day_of_month = '';
double daySize = .5;
double dayWidth = .8;

class DaySelect extends StatefulWidget {
  const DaySelect({Key? key}) : super(key: key);

  @override
  _DaySelectState createState() => _DaySelectState();
}

class _DaySelectState extends State<DaySelect> {
  Color cor_do_botao = Colors.white;
  List<Color> colors = [Colors.white];

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    var boxHeight = screenHeight * daySize;
    List<Widget> listaDeDias = [
      botao(buttonText: '1'),
      botao(buttonText: '2'),
      botao(buttonText: '3'),
      botao(buttonText: '4'),
      botao(buttonText: '5'),
      botao(buttonText: '6'),
      botao(buttonText: '7'),
      botao(buttonText: '8'),
      botao(buttonText: '9'),
      botao(buttonText: '10'),
      botao(buttonText: '11'),
      botao(buttonText: '12'),
      botao(buttonText: '13'),
      botao(buttonText: '14'),
      botao(buttonText: '15'),
      botao(buttonText: '16'),
      botao(buttonText: '17'),
      botao(buttonText: '18'),
      botao(buttonText: '19'),
      botao(buttonText: '20'),
      botao(buttonText: '21'),
      botao(buttonText: '22'),
      botao(buttonText: '23'),
      botao(buttonText: '24'),
      botao(buttonText: '25'),
      botao(buttonText: '26'),
      botao(buttonText: '27'),
      botao(buttonText: '28'),
      botao(buttonText: '29'),
      botao(buttonText: '30'),
      botao(buttonText: '31'),
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: boxHeight * .04,
              runSpacing: boxHeight * .04,
              children: listaDeDias,
            ),
            //
            //
            // TextButton(
            //   onPressed: () {},
            //   child: Text('Confirmar'),
            //  )
          ],
        ),
      ),
    );
  }

  Widget botao({
    required String buttonText,
    //required String index
    // required Function aoPressionar,
    // required Color buttonColor,
  }) {
    var appbar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appbar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    var boxHeight = screenHeight * daySize;
    var buttonSize = boxHeight * .113;
    var textSize = buttonSize * .48;
    var boxWidth = size.width * dayWidth;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          shape: BoxShape.circle),
      height: boxHeight * .113,
      width: boxWidth * .113,
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            day_of_month = buttonText;
          });
        },
        backgroundColor:
            day_of_month == buttonText ? Colors.blue.shade700 : Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: textSize),
        ),
      ),
    );
  }
}



/* 
List.generate(31, (index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        shape: BoxShape.circle),
                    height: boxHeight * .11,
                    width: size.width * .11,
                    child: Center(
                      child: botao(
                        buttonText: (index + 1).toString(),
                        aoPressionar: () {
                          setState(() {
                            colors.add(Colors.blue);
                            
                          });
                        },
                        buttonColor: day_of_month == (index + 1).toString()
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                  );
                }),
*/



/* 

1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
*/