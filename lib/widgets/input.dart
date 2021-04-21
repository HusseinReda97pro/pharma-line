import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';

class Input extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  Input({@required this.hint, @required this.controller});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.midBlue,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Palette.lightBlue, fontSize: 14.0),
          contentPadding: const EdgeInsets.all(6.0),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          //   borderRadius: BorderRadius.circular(25.7),
          // ),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          //   borderRadius: BorderRadius.circular(25.7),
          // ),
        ),
      ),
    );
  }
}
