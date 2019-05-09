import 'package:carros/domain/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;

  const CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (ctx, idx) {
        final c = carros[idx];
        return Container(
          child: InkWell(
            onTap: () {
              _onClickCarro(context, c);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: c.urlFoto != null && c.urlFoto.isNotEmpty
                          ? Image.network(
                              c.urlFoto,
                            )
                          : Image.asset("assets/images/camera.png"),
                    ), //Image
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ), //TextStyle
                    ), // Text
                    Text(
                      c.desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ), //TextStyle
                    ), // Text
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () {
                              _onClickCarro(context, c);
                            },
                          ), //FlatButton
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
                              /* ... */
                            },
                          ), //FlatButton
                        ], //<Widget>
                      ), //ButtonBar
                    ), //ButtonTheme.bar
                  ], //<Widget>
                ),
              ), //Column
            ),
          ), //Card
        ); //Container

//        return Container( //Exemplo imagem expandida.
//          child: Card(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Stack(
//                  alignment: Alignment.topCenter,
//                  children: <Widget>[
//                    Image.network(
//                      c.urlFoto,
//                    ), //Image
//                    Container(
//                      color: Colors.black45,
//                      child: Center(
//                        child: Text(
//                          c.nome,
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 24,
//                          ), //TextStyle
//                        ), // Text
//                      ), //Center
//                    ), //Container
//                  ], //<Widget>
//                ), //Stack
//                ButtonTheme.bar(
//                  child: ButtonBar(
//                    children: <Widget>[
//                      FlatButton(
//                        child: const Text('DETALHES'),
//                        onPressed: () {
//                          /* ... */
//                        },
//                      ), //FlatButton
//                      FlatButton(
//                        child: const Text('SHARE'),
//                        onPressed: () {
//                          /* ... */
//                        },
//                      ), //FlatButton
//                    ], //<Widget>
//                  ), //ButtonBar
//                ), //ButtonTheme.bar
//              ], //<Widget>
//            ), //Column
//          ), //Card
//        ); //Container

//        ListTile(
//          leading: Image.network(
//            c.urlFoto,
//            width: 150,
//          ), //Image
//          title: Text(
//            c.nome,
//            style: TextStyle(
//              color: Colors.blue,
//              fontSize: 24,
//            ),
//          ), //Text
//          subtitle: Text(
//            "descrição",
//            style: TextStyle(
//              color: Colors.black,
//              fontSize: 16,
//            ),
//          ), //Text
//        ), //ListTile

//        return Container( //EXEMPLO 1 DE CARD.
//          height: 150,
//          child: Card(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                ListTile(
//                  leading: Image.network(
//                    c.urlFoto,
//                    width: 150,
//                  ), //Image
//                  title: Text(
//                    c.nome,
//                    style: TextStyle(
//                      color: Colors.blue,
//                      fontSize: 24,
//                    ),
//                  ), //Text
//                  subtitle: Text(
//                    "descrição",
//                    style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 16,
//                    ),
//                  ), //Text
//                ), //ListTile
//                ButtonTheme.bar(
//                  child: ButtonBar(
//                    children: <Widget>[
//                      FlatButton(
//                        child: const Text('DETALHES'),
//                        onPressed: () {
//                          /* ... */
//                        },
//                      ), //FlatButton
//                      FlatButton(
//                        child: const Text('SHARE'),
//                        onPressed: () {
//                          /* ... */
//                        },
//                      ), //FlatButton
//                    ], //<Widget>
//                  ), //ButtonBar
//                ), //ButtonTheme.bar
//              ], //<Widget>
//            ), //Column
//          ), //Card
//        ); //Container
      }, //itemBuilder
    ); //ListView.builder
  }
}

void _onClickCarro(BuildContext context, Carro carro) {
  push(context, CarroPage(carro: carro));
}
