import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final TextEditingController _controller;
  final String _label, _hintText;
  final Icon _icon;

  TextFields(this._controller, this._label, this._hintText, this._icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: this._controller,
        decoration: InputDecoration(
            filled: true,
            labelText: this._label,
            hintText: this._hintText,
            suffix: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                _controller.clear();
              },
            ),
            icon: _icon),
      ),
    );
  }
}
