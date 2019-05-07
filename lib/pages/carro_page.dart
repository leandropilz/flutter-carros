import 'package:carros/domain/carro.dart';
import 'package:carros/domain/services/carro_service.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage({Key key, this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ), //AppBar
      body: _body(), //body
    ); //Scaffold
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(carro.urlFoto),
        _bloco1(), //bloco1
        _bloco2(), //bloco2
      ], //<Widget>
    ); //ListView
  }

  _bloco1() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                carro.nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                carro.tipo,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ], //<Widget>[]
          ), //Column
        ), //Expanded
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 36,
          ), //Icon
        ), //InkWell
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.share,
            size: 36,
          ), //Icon
        ), //InkWell
      ], //<Widget>[]
    );
  }

  _bloco2() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            carro.desc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ), //TextStyle
          ), //Text
          SizedBox(
            height: 8,
          ), //SizedBox
          FutureBuilder(
            future: CarroService.getLoremIpsum(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }, //builder
          ), //FutureBuilder
        ], //<Widget>[]
      ), //Column
    ); //Container
  }
}
