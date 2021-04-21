import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/controllers/university_controller.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/profile_image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File _image;
  University selectedUniversity;
  Faculty selectedFaculty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    }, child: Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
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
                    child: DropdownButton<University>(
                      //value: 'Helwan University',
                      hint: Text(
                        selectedUniversity == null
                            ? 'University'
                            : selectedUniversity.name,
                        style: TextStyle(color: Palette.lightBlue),
                      ),
                      iconSize: 32.0,
                      iconEnabledColor: Palette.lightBlue,
                      isExpanded: true,
                      style: TextStyle(color: Palette.lightBlue),
                      dropdownColor: Palette.midBlue,
                      items: model.universities.map((University university) {
                        return new DropdownMenuItem<University>(
                          value: university,
                          child: new Text(university.name),
                        );
                      }).toList(),
                      onChanged: (university) {
                        print(university);
                        setState(() {
                          selectedUniversity = university;
                        });
                      },
                    ),
                  ),
                ),
              ),
              !(selectedUniversity?.faculties != null)
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      color: Palette.midBlue,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Faculty>(
                            //value: 'Helwan University',
                            hint: Text(
                              selectedFaculty == null
                                  ? 'Faculty'
                                  : selectedFaculty.name,
                              style: TextStyle(color: Palette.lightBlue),
                            ),
                            iconSize: 32.0,
                            iconEnabledColor: Palette.lightBlue,
                            isExpanded: true,
                            style: TextStyle(color: Palette.lightBlue),
                            dropdownColor: Palette.midBlue,
                            items: selectedUniversity.faculties
                                .map((Faculty faculty) {
                              return new DropdownMenuItem<Faculty>(
                                value: faculty,
                                child: new Text(faculty.name),
                              );
                            }).toList(),
                            onChanged: (faculty) {
                              setState(() {
                                selectedFaculty = faculty;
                              });
                            },
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
                    UniversityController().getUniversities();
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
      );
    }));
  }
}
