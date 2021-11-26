import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationForm extends StatefulWidget {

  AuthenticationForm();

  @override
  State<StatefulWidget> createState() => AuthenticationFormState();
}

class AuthenticationFormData {
  String username = '';
  String password = '';
  String error = '';
}

class AuthenticationFormState extends State<AuthenticationForm> {

  final _key = GlobalKey<FormState>();
  var _data = AuthenticationFormData();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 20,
                      ),
                      hintText: 'Login',
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                    ),
                    hintText: 'Senha',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a sua senha';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _data.password = value!;
                  },
                ),
              ],
            ),
          ),
          _data.error != ''
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: Text(
                    _data.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : const SizedBox(),
        ].where((o) => o != null).toList(),
      ),
    );
  }
}
