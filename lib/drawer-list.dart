import 'package:carros/pages/login_page.dart';
import 'package:carros/pages/site_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'domain/user.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 300,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<User>(
                future: User.get(),
                builder: (context, snapshot) {
                  return snapshot.hasData ? Text(snapshot.data.nome) : Text("");
                },
              ),
              accountEmail: FutureBuilder<User>(
                future: User.get(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Text(snapshot.data.email)
                      : Text("");
                },
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.iconscout.com/icon/free/png-256/avatar-372-456324.png"),
              ),
            ),
            ListTile(
              onTap: () {
                print("Item 1");
              },
              title: Text("Item 1"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 2");
              },
              title: Text("Item 2"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 3");
              },
              title: Text("Item 3"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Configurações");
              },
              title: Text("Configurações"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              onTap: () {
                _onClickSite(context);
              },
              title: Text("Visite o site"),
              leading: Icon(Icons.web),
            ),
            ListTile(
              onTap: () {
                print("Ajuda");
              },
              title: Text("Ajuda"),
              leading: Icon(Icons.help),
            ),
            ListTile(
              onTap: () {
                _logout(context);
              },
              title: Text("Logout"),
              leading: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    print("Logout");
    pop(context);
    pushReplacement(context, LoginPage());
    User.clear();
  }

  void _onClickSite(context) {
    pop(context);
    push(context, SitePage());
  }
}
