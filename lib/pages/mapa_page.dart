import 'package:carros/domain/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  const MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ), //AppBar
      body: _body(),
    ); //Scaffold
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _latLng(),
          zoom: 17,
        ), //CameraPosition
        markers: Set.of(_getMarkes()),
      ), //GoogleMap
    ); //Container
  }

  _latLng() => carro.latlng();

  _getMarkes() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: _latLng(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: "Fábria da ${carro.nome}",
          onTap: (){
            print("Clicou na janela.");
          }
        ), //InfoWindow
        onTap: (){
          print("Clicou no marcador.");
        }
      ) //Marker
    ];
  }
}
