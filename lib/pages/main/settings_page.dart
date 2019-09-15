import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/auth.dart';

import '../login_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          child: OutlineButton(
            onPressed: () {

            },
            child: Text('Alertas'),
          ),
        ),
        Container(
          width: width,
          child: OutlineButton(
            onPressed: () {

            },
            child: Text('Doe pela causa'),
          ),
        ),
        Container(
          width: width,
          child: OutlineButton(
            onPressed: () {

            },
            child: Text('Esqueci minha senha'),
          ),
        ),
        Container(
          width: width,
          child: OutlineButton(
            onPressed: () {
              Auth _auth = new Auth();
              _auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text('Sign out'),
          )
          ,
        )
      ]
      ,
    );
  }
}
