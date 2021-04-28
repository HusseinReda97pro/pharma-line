import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';
import 'package:pharma_line/models/user.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/loading_box.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static final String route = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  File image;
  University selectedUniversity;
  Faculty selectedFaculty;
  final picker = ImagePicker();

  Future<void> _showErrors(BuildContext context, List<String> errors) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          content: Container(
            width: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: errors.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(errors[index]));
              },
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Palette.midBlue;
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'okay',
                  textAlign: TextAlign.center,
                ))
          ],
        );
      },
    );
  }

  Future<void> _signedUpSuccessfully(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          content: Container(
            width: 100,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('Signed Up Successfully'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Palette.midBlue;
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(HomeScreen.route));
                },
                child: Text(
                  'okay',
                  textAlign: TextAlign.center,
                ))
          ],
        );
      },
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    }, child: Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Palette.darkBlue,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Container(
                      width: 150.0,
                      height: 150,
                      child: Stack(
                        children: [
                          Container(
                            width: 150.0,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              border: Border.all(
                                  color: Palette.lightBlue, width: 3.0),
                            ),
                            child: ClipOval(
                              child: image != null
                                  ? Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/profile_picture_placeholder.jpg',
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: -5,
                            right: -10,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Palette
                                        .darkBlue; // Use the component's default.
                                  },
                                ),
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  CircleBorder(
                                    side: BorderSide(color: Palette.lightBlue),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                getImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Palette.lightBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
              Input(
                hint: 'First Name',
                controller: firstNameController,
              ),
              Input(
                hint: 'Last Name',
                controller: lastNameController,
              ),
              Input(
                hint: 'E-mail',
                controller: emailController,
              ),
              Input(
                hint: 'Phone Number',
                controller: phoneNumberController,
              ),
              Input(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              Input(
                hint: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: true,
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
                  style: ElevatedButton.styleFrom(primary: Palette.lightBlue),
                  onPressed: () async {
                    List<String> errors = [];
                    if (emailController.text.isEmpty) {
                      errors.add('Email is required.');
                    }
                    if (firstNameController.text.isEmpty) {
                      errors.add('First Name is required.');
                    }
                    if (lastNameController.text.isEmpty) {
                      errors.add('Last Name is required.');
                    }
                    if (phoneNumberController.text.isEmpty) {
                      errors.add('Phone Number is required.');
                    }

                    if (passwordController.text.isEmpty) {
                      errors.add('Password is required.');
                    }
                    if (confirmPasswordController.text.isEmpty) {
                      errors.add('Confrim Password is required.');
                    }
                    if ((confirmPasswordController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) &&
                        passwordController.text !=
                            confirmPasswordController.text) {
                      errors.add('passwords don\'t match.');
                    }
                    if (selectedFaculty == null) {
                      errors.add('Faculty is required.');
                    }

                    if (errors.length > 0) {
                      _showErrors(context, errors);
                    } else {
                      if (emailController.text.isNotEmpty &&
                          firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          selectedFaculty != null) {
                        loadingBox(context);
                        User user = User(
                            email: emailController.text.trim(),
                            facultyId: selectedFaculty.id,
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            phoneNumber: phoneNumberController.text.trim());
                        var res = await model.signUp(
                            user: user,
                            password: passwordController.text,
                            image: image);
                        Navigator.pop(context);
                        if (res != null) {
                          _showErrors(context, res['errors']);
                        } else {
                          _signedUpSuccessfully(context);
                        }
                      }
                    }
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Text('+'),
        //   onPressed: () {
        //     print(model.universities);
        //   },
        // ),
      );
    }));
  }
}
