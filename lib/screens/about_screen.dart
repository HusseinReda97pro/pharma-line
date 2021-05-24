import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: ListView(children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            'About App:',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            'for courses and other services to pharmacy students specialy Fopcu students.',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            'contact us via:',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),


        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: ()  {
              String url = 'https://www.facebook.com/pharma.line.fans';



               launch(
                  url,
                  enableJavaScript: true,
                  forceSafariVC: true,
                  forceWebView: true,

                  // headers: <String, String>{'my_header_key': 'my_header_value'},
                );



            },
            child: Row(
              children: [


                Icon(
                  FontAwesomeIcons.facebook,
                  size: 18.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'Facebook Page.',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () async {
              String phone = '+201212643161';
              String message = 'I have a question. Can you help?';
              String url;
              if (Platform.isAndroid) {
                // add the [https]
                url =
                    "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
              } else {
                // add the [https]
                url =
                    "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
              }

                await launch(
                  url,
                  // forceSafariVC: true,
                  // forceWebView: true,
                  // headers: <String, String>{'my_header_key': 'my_header_value'},
                );

            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 18.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'Whatsapp.',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            'visit us:',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () async {
              String url =
                  'https://www.google.com/maps/dir/30.0746496,31.2486105/30.0338234,31.2294531/@30.0567972,31.2592609,14z/data=!3m1!4b1!4m4!4m3!1m1!4e1!1m0';
                await launch(
                  url,

                  // headers: <String, String>{'my_header_key': 'my_header_value'},
                );

            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 18.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'Garden City, Cairo.',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
