import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final TextEditingController _controller;
  final String _label, _hintText;
  final Icon _icon;

  TextFields(this._controller, this._label, this._hintText, this._icon);

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            icon: _icon,
            hintText: _hintText,
            labelText: _label,
          ),
          onChanged: (value) {},
        ),
      );
    });
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _label, _hintText;
  final Icon _icon;

  PasswordTextField(this._controller, this._label, this._hintText, this._icon);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: _icon,
            hintText: _hintText,
            labelText: _label,
          ),
          onChanged: (value) {},
        ),
      );
    });
  }
}
