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
          keyboardType: TextInputType.text,
          onChanged: (value) {},
        ),
      );
    });
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController _controller;
  final String _label, _hintText;
  final Icon _icon;

  PasswordTextField(this._controller, this._label, this._hintText, this._icon);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _ocultar = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: widget._controller,
          keyboardType: TextInputType.emailAddress,
          obscureText: _ocultar,
          decoration: InputDecoration(
              icon: widget._icon,
              hintText: widget._hintText,
              labelText: widget._label,
              suffixIcon: IconButton(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  _ocultar ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _ocultar = !_ocultar;
                  });
                },
              )),
          onChanged: (value) {},
        ),
      );
    });
  }
}

class TextFieldsNumbers extends StatelessWidget {
  final TextEditingController _controller;
  final String _label, _hintText;
  final Icon _icon;

  TextFieldsNumbers(this._controller, this._label, this._hintText, this._icon);

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
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        ),
      );
    });
  }
}
