import 'package:carros/db.dart';
import 'package:carros/domain/carro.dart';
import 'package:carros/domain/services/carro_service.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  @override
  bool get wantKeepAlive => true;

  _body() {
    Future<List<Carro>> future = DB.getInstance().getAllCarros();
    return Container(
      padding: EdgeInsets.all(8),
      //FutureBuilder, banco de dados, web sevice e constroi uma widget com base em um future.
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Carro> carros = snapshot.data;
            return CarrosListView(carros);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Nenhum carro disponível.",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ), //Text
            ); //Center
          } else {
            return Center(
              child: CircularProgressIndicator(),
            ); //Center
          }
        },
      ), //FutureBuilder
    ); //Container
  }
}
