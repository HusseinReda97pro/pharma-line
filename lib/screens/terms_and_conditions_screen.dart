import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pharma_line/config/terms.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  static const route = '/terms';
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(context: context),
      drawer: AppDrawer(),
      body: ListView(children: [
        Html(data: terms, style: {'*': Style(color: Colors.white)})
      ]),
    );
  }
}
