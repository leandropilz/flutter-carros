import 'package:carros/db.dart';
import 'package:carros/domain/carro.dart';
import 'package:carros/domain/services/carro_service.dart';
import 'package:carros/pages/carro-form-page.dart';
import 'package:carros/pages/video_page.dart';
import 'package:carros/utils/alerts.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage({Key key, this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    DB().exists(carro).then((isSaved) {
      if (isSaved) {
        setState(() {
          _isSaved = isSaved;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.place), onPressed: () {}), //IconButton
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {
                _onClickVideo(context);
              }), //IconButton
          PopupMenuButton<String>(
            onSelected: (value) {
              _onClickPopupMenu(value);
            }, //onSelected
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ), //PopupMenuItem
                PopupMenuItem(
                  value: "Excluir",
                  child: Text("Excluir"),
                ), //PopupMenuItem
                PopupMenuItem(
                  value: "Compartilhar",
                  child: Text("Compartilhar"),
                ), //PopupMenuItem
              ]; //return []
            }, //itemBuilder
          ), //PopupMenuButton
        ], //<Widget>
      ), //AppBar
      body: _body(), //body
    ); //Scaffold
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        carro.urlFoto != null
            ? Image.network(
                carro.urlFoto,
              )
            : Image.asset("assets/images/camera.png"),
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
          onTap: () {
            _onClickFavorito(context, carro);
          },
          child: Icon(
            Icons.favorite,
            color: _isSaved ? Colors.red : Colors.grey,
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

  void _onClickFavorito(BuildContext context, carro) async {
    final db = DB.getInstance();

    final exists = await db.exists(carro);

    if (exists) {
      db.deleteCarro(carro.id);
    } else {
      int id = await db.saveCarro(carro);
      print("Carro salvo $id");
    }

    setState(() {
      _isSaved = !exists;
    });
  }

  void _onClickPopupMenu(String value) {
    if (value == "Editar") {
      push(context, CarroFormPage(carro: carro));
    } else if (value == "Excluir") {
      _deletar();
    }
  }

  void _deletar() async {
    final response = await CarroService.excluir(carro.id);
    if (response.isOk()) {
      pop(context);
    } else {
      alert(context, "Erro", response.msg);
    }
  }

  void _onClickVideo(BuildContext context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      //launch(carro.urlVideo);  //Abre o vídeo no browser nativo do device.
      push(context, VideoPage(carro));
    } else {
      alert(
        context,
        "Erro",
        "Este carro não possui nenhum vídeo",
      );
    }
  }
}
