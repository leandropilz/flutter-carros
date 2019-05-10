import 'package:carros/domain/tipo_carro.dart';
import 'package:carros/pages/carro-form-page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/carros_page.dart';
import 'package:carros/widgets/favoritos_page.dart';
import 'package:flutter/material.dart';

import '../drawer-list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    Prefs.getInt("tab").then((idx) {
      tabController.index = idx;
    });

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() async {
      Prefs.setInt("tab", tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ), //Tab
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ), //Tab
            Tab(
              text: "Luxuosos",
              icon: Icon(Icons.directions_car),
            ), //Tab
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            ), //Tab
          ], //tabs
        ), //TabBar
      ), //AppBar
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          CarrosPage(TipoCarro.classicos), //CarrosPage
          CarrosPage(TipoCarro.esportivos), //CarrosPage
          CarrosPage(TipoCarro.luxo), //CarrosPage
          FavoritosPage(), //FavoritosPage
        ], //<Widget>
      ), //TabBarView
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          push(context, CarroFormPage());
        },
      ), //FloatingActionButton
      drawer: DrawerList(), //Drawer
    ); //Scaffold
  }
}
