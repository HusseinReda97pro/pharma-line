import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final Function onPressed;
  RoundedButton(
      {@required this.backgroundColor,
      @required this.icon,
      @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return backgroundColor; // Use the component's default.
          },
        ),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) {
          return EdgeInsets.all(0);
        }),
        minimumSize: MaterialStateProperty.resolveWith<Size>(
            (Set<MaterialState> states) {
          return Size(0, 0);
        }),
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(),
        ),
      ),
      onPressed: onPressed,
      child: Container(padding: EdgeInsets.all(5.0), child: icon),
    );
  }
}
