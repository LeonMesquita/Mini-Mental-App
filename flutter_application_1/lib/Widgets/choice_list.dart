import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/constantes.dart';

String diaDaSemana = '';
String mesAtual = '';
String diaDoMes = '';

class ChoiceList extends StatefulWidget {
  List<String> listItems = [];
  String initialValue;
  ChoiceList({required this.listItems, required this.initialValue});

  @override
  _ChoiceListState createState() => _ChoiceListState();
}

class _ChoiceListState extends State<ChoiceList> {
  List<String> myItems = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo'
  ];
  String currentValue = 'Segunda';
  String dropdownValue = 'Segunda';

  void atribuirDia() {
    if (widget.listItems[1] == 'Segunda') {
      diaDaSemana = widget.initialValue;
    } else if (widget.listItems[1] == 'Janeiro') {
      mesAtual = widget.initialValue;
    }
  }

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
    var containerHeight = screenHeight * .10;
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        value: widget.initialValue,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: kPurpleColor,
          size: 40,
        ),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            //dropdownValue = newValue!;

            widget.initialValue = newValue!;
            atribuirDia();
          });
        },
        items: widget.listItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: _maxValue(value: containerHeight * .37, max: 18),
                  color: kPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}





/*

Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 4)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          //
          value: items.first,
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => this.value = value!),
          isExpanded: true,
          //
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );

*/


/*

DropdownButton<String>(
          //
          value: 'segunda',
          items: myItems.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem<String>(
              child: Text(items),
              value: items,
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              currentValue = newValue!;
            });
          },
          isExpanded: true,
          //
        ),

*/