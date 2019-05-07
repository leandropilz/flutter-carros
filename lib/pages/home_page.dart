import 'package:carros/domain/tipo_carro.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    tabController = TabController(length: 3, vsync: this);
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
          ], //tabs
        ), //TabBar
      ), //AppBar
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          CarrosListView(TipoCarro.classicos), //CarrosListView
          CarrosListView(TipoCarro.esportivos), //CarrosListView
          CarrosListView(TipoCarro.luxo), //CarrosListView
        ], //<Widget>
      ), //TabBarView
    ); //Scaffold
  }
}
