import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Testes%20Cognitivos/MEEM/meem.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

String country = '';
String city = '';
String state = '';
Placemark _address = Placemark();
List placemark = [];
//
//
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Você precisa habilitar a localização');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Por favor, habilite a localização');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Por favor, habilite a localização');
  }
  return await Geolocator.getCurrentPosition();
}

//
//
Future updatePosition() async {
  Position pos = await determinePosition();

  placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);
  //_latitude = pos.latitude.toString();
  // _longitude = pos.longitude.toString();
  _address = placemark[0];
  country = _address.country.toString().toLowerCase();
  city = _address.subAdministrativeArea.toString().toLowerCase();
  state = _address.administrativeArea.toString().toLowerCase();
}

String retornarLocalidade() {
  updatePosition();
  //_address = placemark[0];
  country = _address.country.toString().toLowerCase();
  city = _address.subAdministrativeArea.toString().toLowerCase();
  state = _address.administrativeArea.toString().toLowerCase();
  return '';
}

void retornarLocalizacao() {
  updatePosition();
}

class GetPosition extends StatefulWidget {
  StatefulWidget returnedWidget;
  GetPosition({required this.returnedWidget});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GetPosition> {
//
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: updatePosition(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Container();
                  } else {
                    return widget.returnedWidget;
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
