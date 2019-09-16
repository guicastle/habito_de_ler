import 'package:ant_icons/ant_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/auth.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/user.dart';
import 'package:habito_de_ler/utils/colors.dart';
import 'package:habito_de_ler/utils/space_utils.dart';

import 'main_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final formKey = GlobalKey<FormState>();

  bool _loading = false;
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _passwordConfirm;

  @override
  void initState() {
    super.initState();
    _username = new TextEditingController();
    _email = new TextEditingController();
    _password = new TextEditingController();
    _passwordConfirm = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24, top: 10, right: 24),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: !_loading,
                        validator: (value) =>
                            value.isEmpty ? 'Campo email obrigatório' : null,
                        controller: _username,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(AntIcons.user),
                        ),
                      ),
                      SpaceUtils.column(30),
                      TextFormField(
                        enabled: !_loading,
                        validator: (value) =>
                            value.isEmpty ? 'Campo email obrigatório' : null,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SpaceUtils.column(30),
                      TextFormField(
                        enabled: !_loading,
                        validator: (value) =>
                            value.isEmpty ? 'Campo senha obrigatório' : null,
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      SpaceUtils.column(30),
                      TextFormField(
                        enabled: !_loading,
                        validator: (value) =>
                            value.isEmpty ? 'Campo senha obrigatório' : null,
                        controller: _passwordConfirm,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirmar senha',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      SpaceUtils.column(42),
                      ButtonTheme(
                        minWidth: 250.0,
                        height: 40.0,
                        child: RaisedButton(
                          colorBrightness: Brightness.dark,
                          child: new Text(
                            'Cadastrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Sans Medium',
                            ),
                          ),
                          highlightElevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: accentColor,
                          onPressed: () async {
                            if (_password.text != _passwordConfirm.text) {
                              /// ALERTA SE A SENHA FOR DIFERENTE
                              return;
                            }
                            Auth _auth = new Auth();
                            await _auth
                                .createUserWithEmailAndPassword(
                                    _email.text, _password.text, _username.text)
                                .then((isSave) {
                              if (isSave) {
                                _auth.signInWithEmailAndPassword(_email.text, _password.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                              } else {
                                /// Erro em salvar
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
