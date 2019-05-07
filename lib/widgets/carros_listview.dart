import 'package:carros/domain/carro.dart';
import 'package:carros/domain/services/carro_service.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;

  const CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  @override
  bool get wantKeepAlive => true;

  _body() {
    Future future = CarroService.getCarros(widget.tipo);
    return Container(
      padding: EdgeInsets.all(8),
      //FutureBuilder, banco de dados, web sevice e constroi uma widget com base em um future.
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Nenhum carro disponível.",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ), //Text
            ); //Center
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            ); //Center
          }
          return _listView(snapshot.data); //ListView
        },
      ), //FutureBuilder
    ); //Container
  }

  _listView(List<Carro> carros) {
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
                      child: Image.network(
                        c.urlFoto,
                      ),
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

  void _onClickCarro(BuildContext context, Carro carro) {
    push(context, CarroPage(carro: carro));
  }
}
