import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/auth.dart';
import 'package:habito_de_ler/utils/colors.dart';
import 'package:habito_de_ler/utils/space_utils.dart';

import 'main_page.dart';
import 'new_account_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, loginGoogle, forgetPassword }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          SpaceUtils.column(72.0),
//          Container(
//            padding: EdgeInsets.only(left: 24.0, right: 24.0),
//            child: Row(
//              children: <Widget>[
//                Image.asset(
//                  'images/img_logo_negative.png',
//                  height: 56.0,
//                ),
//                SpaceUtils.row(16.0),
//                Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Image.asset(
//                        'images/img_ionz.png',
//                        height: 32.0,
//                        color: Colors.white,
//                      ),
//                      SpaceUtils.column(4.0),
//                      Image.asset(
//                        'images/img_slogan.png',
//                        height: 24.0,
//                        color: Colors.white,
//                      ),
//                    ])
//              ],
//            ),
//          ),
          SpaceUtils.column(32.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 48.0, right: 48.0),
              decoration: new BoxDecoration(
                color: Colors.black26,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black26, blurRadius: 5)
                ],
              ),
              child: Form(
                key: formKey,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Container(
                      width: width,
                      child: Column(
                        children: <Widget>[
                          SpaceUtils.column(56),
                          Column(
                            children: emailAndPassword() + buttonsActions(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: missing_return
  List<Widget> emailAndPassword() {
    if (_formType == FormType.login)
      return [
        new TextFormField(
          enabled: !_loading,
          validator: (value) =>
              value.isEmpty ? 'Campo email obrigatório' : null,
          onSaved: (value) => _email = value,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SpaceUtils.column(30),
        new TextFormField(
          enabled: !_loading,
          validator: (value) =>
              value.isEmpty ? 'Campo senha obrigatório' : null,
          onSaved: (value) => _password = value,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            prefixIcon: Icon(Icons.lock_outline),
          ),
        ),
      ];
    else if (_formType == FormType.forgetPassword)
      return [
        new TextFormField(
          enabled: !_loading,
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              value.isEmpty ? 'Campo email obrigatório' : null,
          onSaved: (value) => _email = value,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ];
  }

  // ignore: missing_return
  List<Widget> buttonsActions() {
    if (_loading)
      return [
        SpaceUtils.column(32),
        CircularProgressIndicator(),
      ];
    if (_formType == FormType.login) {
      return [
        SpaceUtils.column(16),
        FlatButton(
          child: new Text(
            'Esqueci minha senha',
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Sans Medium',
            ),
          ),
          //onPressed: moveToForgetPassword,
        ),
        SpaceUtils.column(16),
        ButtonTheme(
          minWidth: 230.0,
          height: 38.0,
          child: Column(
            children: <Widget>[
              signInButton(),
              SpaceUtils.column(4),
              _googleSignInButton(),
              SpaceUtils.column(56),
              FlatButton(
                child: Text(
                  'Não tem cadastro? \nCadastre aqui',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Sans Medium',
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountPage()));
                },
              ),
            ],
          ),
        ),
      ];
    } else if (_formType == FormType.forgetPassword) {
      return [
        SpaceUtils.column(50),
        ButtonTheme(
          minWidth: 250.0,
          height: 50.0,
          child: RaisedButton(
            colorBrightness: Brightness.dark,
            child: new Text(
              'Recuperar senha',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Sans Medium',
              ),
            ),
            highlightElevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Theme.of(context).accentColor,
            //onPressed: validateAndSubmit,
          ),
        ),
        SpaceUtils.column(30),
        FlatButton(
          child: new Text(
            'Voltar',
            style: TextStyle(
              fontFamily: 'Sans Medium',
            ),
          ),
          //onPressed: moveToLogin,
        ),
      ];
    }
  }

  signInButton() {
    return RaisedButton(
      colorBrightness: Brightness.dark,
      child: new Text(
        'Entrar',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Sans Medium',
        ),
      ),
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: accentColor,
      onPressed: () {
        final form = formKey.currentState;
        if (!form.validate()) return;

        form.save();

        Auth _auth = new Auth();
        Future<FirebaseUser> response =
            _auth.signInWithEmailAndPassword(_email, _password);
        response.then(
          (user) {
            if (user.uid != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
          },
        );
      }, //onPressed: validateAndSubmit,
    );
  }

  Widget _googleSignInButton() {
    return RaisedButton(
      color: Colors.white,
      splashColor: Colors.grey,
      onPressed: () {
        Auth _auth = new Auth();
        Future<FirebaseUser> response = _auth.googleSignIn();
        response.then(
          (user) {
            if (user.uid != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("images/google_logo.png"),
              height: 28.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Faça login no Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
