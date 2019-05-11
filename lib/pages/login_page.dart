import 'dart:io';

import 'package:carros/domain/services/login_service.dart';
import 'package:carros/firebase/firebase-service.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/alerts.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLoginController =
      TextEditingController(text: "leandro.pilzz@gmail.com");
  final _tPasswController = TextEditingController(text: "12345678");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  var _progress = false;

  @override
  void initState() {
    super.initState();
    _initRemoteConfig();
    _initFcm();
  }

  void _initRemoteConfig() {
    RemoteConfig.instance.then((remoteConfig) {
      try {
        remoteConfig
            .setConfigSettings(new RemoteConfigSettings(debugMode: true));
        remoteConfig.fetch(expiration: const Duration(minutes: 1));
        remoteConfig.activateFetched();
        final message = remoteConfig.getString("mensagem");
        print('Mensagem: $message');
      } catch (error) {
        print('Remote config: $error');
      }
    });
  }

  void _initFcm() {
    _firebaseMessaging.getToken().then((token) {
      print("TOKEN [ $token ]");
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("\n\n\nonResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("\n\n\nonLaunch: $message");
    });

    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("iOS Push Settings: [$settings]");
      });
    }
  }

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
            style: TextStyle(color: Colors.black, fontSize: 20),
//            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: "Login",
              labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
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
              style: TextStyle(color: Colors.black, fontSize: 20),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
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
              child: _progress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ) //CircularProgressIndicator
                  : Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ), //TextStyle
                    ), //Text
            ), //RaisedButton
          ), //Container
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20),
            child: GoogleSignInButton(
              text: "Login com Google",
              onPressed: () {
                _onClickLoginGoogle();
              },
            ), //GoogleSignInButton
          ), //Container
        ], //<Widget>
      ), //ListView
    ); //Form
  }

  _onClickLogin(BuildContext context) async {
    final login = _tLoginController;
    final passw = _tPasswController;

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final response = await LoginService.login(login.text, passw.text);

    setState(() {
      _progress = false;
    });

    if (response.isOk()) {
      pushReplacement(context, HomePage());
    } else {
      alert(context, "Erro", response.msg);
    }
  }

  void _onClickLoginGoogle() async {
    final service = FirebaseService();
    final response = await service.loginGoogle();

    if (response.isOk()) {
      pushReplacement(context, HomePage());
    } else {
      alert(context, "Erro", response.msg);
    }
  }
}
