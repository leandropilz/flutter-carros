import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _tLoginController =
      TextEditingController(text: "leandro.pilzz@gmail.com");
  final _tPasswController = TextEditingController(text: "12345678");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ), //appBar
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ), // Padding
    );
  }

  String _validatorLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validatorPasswd(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    } else if (text.length < 2) {
      return "Senha precisa ter mais de dois dígitos";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _tLoginController,
            validator: _validatorLogin,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black, fontSize: 16),
//            textCapitalization: TextCapitalization.characters,
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
              validator: _validatorPasswd,
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
              onPressed: () {
                _onClickLogin(context);
              },
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

  _onClickLogin(BuildContext context) {
    final login = _tLoginController;
    final passw = _tPasswController;

    if (!_formKey.currentState.validate()) {
      return;
    }

    print("Login ${login.text}, senha ${passw.text}");
  }
}
