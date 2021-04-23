import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/profile_image_picker.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  static String route = '/user_info';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: MainAppBar(
            context: context,
          ),
          drawer: AppDrawer(),
          body: ListView(
            children: [
              ProfileImagePicker(
                  image: _image, imageUrl: model.currentUser.profileImageUrl , model: model,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  model.currentUser.firstName +
                      ' ' +
                      model.currentUser.lastName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Palette.lightBlue, fontSize: 18.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Points: ' + model.currentUser.points.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Palette.lightBlue, fontSize: 12.0),
                ),
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
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 20.0,
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
                    //TODO update user info
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
