import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextField({this.label, this.maxLines = 1, this.minLines = 1, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: TextStyle(color: Colors.white),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          
          enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
    ));
  }
}
