import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/profile_image_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Palette.darkBlue,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 14.0,
                  color: Palette.lightBlue,
                ),
                Text(
                  'Login',
                  style: TextStyle(color: Palette.lightBlue),
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ProfileImagePicker(
                image: _image,
              ),
              Input(
                hint: 'Name',
                controller: nameController,
              ),
              Input(
                hint: 'E-mail',
                controller: emailController,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                color: Palette.midBlue,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      //value: 'Helwan University',
                      hint: Text(
                        'University',
                        style: TextStyle(color: Palette.lightBlue),
                      ),
                      iconSize: 32.0,
                      iconEnabledColor: Palette.lightBlue,
                      isExpanded: true,
                      style: TextStyle(color: Palette.lightBlue),
                      dropdownColor: Palette.midBlue,
                      items: <String>[
                        'Helwan University',
                        'Cairo University',
                        'Alex University'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                color: Palette.midBlue,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      //value: 'Helwan University',
                      hint: Text(
                        'Faculty',
                        style: TextStyle(color: Palette.lightBlue),
                      ),
                      iconSize: 32.0,
                      iconEnabledColor: Palette.lightBlue,
                      isExpanded: true,
                      style: TextStyle(color: Palette.lightBlue),
                      dropdownColor: Palette.midBlue,
                      items: <String>[
                        'Faculty of computer science',
                        'Faculty of computer science',
                        'Faculty of computer science'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Palette
                            .lightBlue; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    //TODO signup
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
