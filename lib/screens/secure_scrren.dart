import 'package:flutter/material.dart';
import 'package:secure_application/secure_application.dart';

class SecureScrren extends StatefulWidget {
  final Widget screen;
  SecureScrren({@required this.screen});

  @override
  State<StatefulWidget> createState() {
    return _SecureScrrenState();
  }
}

class _SecureScrrenState extends State<SecureScrren> {
  Widget build(BuildContext context) {
    return SecureApplication(
      child: SecureGate(
        child: Builder(builder: (context) {
          try {
            var valueNotifier = SecureApplicationProvider.of(context);
            valueNotifier.secure();
          } catch (_) {}
          return widget.screen;
        }),
      ),
    );
  }
}
