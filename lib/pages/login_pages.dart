import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _tLoginController = TextEditingController();
  final _tPasswController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ), //appBar
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(),
      ), // Padding
    );
  }

  _body() {
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _tLoginController,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontSize: 16),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: "Login",
              labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
              hintText: "Digite o seu login.",
              hintStyle: TextStyle(color: Colors.black87),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(),
              ), //OutlineInputBorder
            ), //InputDecoration
          ), //TextFormField Login
          Container(
            margin: EdgeInsets.only(top: 16),
            child: TextFormField(
              controller: _tPasswController,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black, fontSize: 16),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
                hintText: "Digite o sua senha.",
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(),
                ), //OutlineInputBorder
              ), //InputDecoration
            ), //TextFormField Senha  Container
          ), //Container
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              onPressed: _onClickLogin,
              color: Colors.blue,
              child: Text(
                "Entrar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ), //TextStyle
              ), //Text
            ), //RaisedButton
          ) //Container
        ], //<Widget>
      ), //ListView
    ); //Form
  }

  _onClickLogin() {
    final login = _tLoginController;
    final passw = _tPasswController;
    print("Login ${login.text}, senha ${passw.text}");
  }
}
