import 'package:flutter/material.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';

class AboutScreen extends StatefulWidget {
  static const route = '/about';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(context: context),
      drawer: AppDrawer(),
      body: ListView(children: [Text('about')]),
    );
  }
}
