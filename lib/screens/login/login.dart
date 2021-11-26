import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:podfy/components/button/button.dart';
import 'package:podfy/screens/home/home.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new LoginState();
}

class AuthenticationFormData {
  String username = '';
  String password = '';
  String error = '';
}

class LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  var _data = new AuthenticationFormData();
  bool buttonPressed = false;

  LoginState();

  usernameValidate(String username) {
    return buttonPressed && username.isEmpty
        ? 'Digite um usuário válido'
        : null;
  }

  usernameSuffix(String username) {
    return buttonPressed && username.isEmpty ? 'Usuário inválido' : '';
  }

  passwordValidate(String password) {
    return buttonPressed && password.isEmpty ? 'Digite sua senha' : null;
  }

  passwordSuffix(String password) {
    return buttonPressed && password.isEmpty ? 'Senha inválida' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: Image(image: AssetImage('assets/logo-roxa.png')),
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: TextFormField(
                              autofocus: false,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
                                suffixIcon:
                                    Icon(Icons.person_outline, size: 20),
                                hintText: 'Digite seu login',
                              ),
                              validator: (value) => usernameValidate(value!),
                              onChanged: (String value) =>
                                  _data.username = value),
                        ),
                        const Text(
                          'Senha',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
                              suffixIcon: Icon(Icons.lock_outline, size: 20),
                              hintText: 'Digite sua senha',
                            ),
                            validator: (value) => passwordValidate(value!),
                            onChanged: (String value) =>
                                _data.password = value),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Column(
                      children: <Widget>[
                        Button(
                          isOutline: false,
                          enabled: true,
                          text: 'ENTRAR',
                          onPressed: () {
                            setState(() {
                              buttonPressed = true;
                            });
                            if (_key.currentState!.validate()) {
                              const Home();
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Não possui conta?'),
                            FlatButton(
                                padding: const EdgeInsets.all(0),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                child: const Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ])),
      )),
    );
  }
}
