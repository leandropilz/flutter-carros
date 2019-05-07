import 'package:flutter/material.dart';

alert(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ), //FlatButton
          ], //<Widget>
        ); //AlertDialog
      }); //showDialog
}
