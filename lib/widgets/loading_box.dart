import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharma_line/config/Palette.dart';

Future<void> loadingBox(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0.0),
        elevation: 0.0,
        content: Container(
          width: 80,
          height: 100,
          child: SpinKitFadingCircle(
            size: 100.0,
            color: Palette.midBlue,
            // itemBuilder: (BuildContext context, int index) {
            //   return DecoratedBox(
            //     decoration: BoxDecoration(
            //       color: index.isEven ? Palette.midBlue : Palette.darkBlue,
            //     ),
            //   );
            // },
          ),
        ),
      );
    },
  );
}
