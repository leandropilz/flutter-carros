import 'dart:io';

import 'package:carros/domain/services/carros_bloc.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  final _bloc = CarrosBlock();

  get tipo => widget.tipo;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  @override
  bool get wantKeepAlive => true;

  _body() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.all(8),
        //FutureBuilder, banco de dados, web sevice e constroi uma widget com base em um future.
        child: StreamBuilder(
          stream: _bloc.getStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarrosListView(snapshot.data);
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              return Center(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 120, bottom: 120),
                          child: Text(
                            error is SocketException
                                ? "Conexão indisponível, por favor verifique sua internet."
                                : "Ocorreu um erro ao buscar a lista de carros.",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                background: Paint()..color = Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ], //<Widget>[]
                ), //ListView
              ); //Center
            } else {
              return Center(
                child: CircularProgressIndicator(),
              ); //Center
            }
          },
        ), //StreamBuilder
      ), //Container
    ); //RefreshIndicator
  }

  Future<void> _onRefresh() {
    print("onRefresh()");
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}
