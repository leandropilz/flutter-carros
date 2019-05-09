import 'package:carros/domain/carro.dart';
import 'package:carros/domain/services/carro_service.dart';
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
