import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';
import 'package:pharma_line/models/user.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/loading_box.dart';
import 'package:pharma_line/widgets/profile_image_picker.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  static String route = '/user_info';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File image;
  University selectedUniversity;
  Faculty selectedFaculty;

  @override
  void initState() {
    User user = MyApp.mainModel.currentUser;
    if (user != null) {
      emailController.text = user.email;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      phoneNumberController.text = user.phoneNumber;
    }

    super.initState();
  }

  final picker = ImagePicker();

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

  Future<void> _UpdatedSuccessfully(BuildContext context) async {
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
                Text('Updated Successfully'),
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
                                  : model.currentUser.profileImageUrl != null
                                      ? Image.network(
                                          "https://pharmaline.herokuapp.com/api/v1/student/profilePicture",
                                          headers: {
                                            "Authorization":
                                                model.currentUser.token
                                          },
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
                enabled: false,
              ),
              Input(
                hint: 'Phone Number',
                controller: phoneNumberController,
                enabled: false,
              ),
              Input(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //       vertical: 5.0,
              //       horizontal: MediaQuery.of(context).size.width * 0.05),
              //   color: Palette.midBlue,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 5.0),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<University>(
              //         //value: 'Helwan University',
              //         hint: Text(
              //           selectedUniversity == null
              //               ? 'University'
              //               : selectedUniversity.name,
              //           style: TextStyle(color: Palette.lightBlue),
              //         ),
              //         iconSize: 32.0,
              //         iconEnabledColor: Palette.lightBlue,
              //         isExpanded: true,
              //         style: TextStyle(color: Palette.lightBlue),
              //         dropdownColor: Palette.midBlue,
              //         items: model.universities.map((University university) {
              //           return new DropdownMenuItem<University>(
              //             value: university,
              //             child: new Text(university.name),
              //           );
              //         }).toList(),
              //         onChanged: (university) {
              //           print(university);
              //           setState(() {
              //             selectedUniversity = university;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // !(selectedUniversity?.faculties != null)
              //     ? SizedBox.shrink()
              //     : Container(
              //         margin: EdgeInsets.symmetric(
              //             vertical: 5.0,
              //             horizontal: MediaQuery.of(context).size.width * 0.05),
              //         color: Palette.midBlue,
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: 5.0),
              //           child: DropdownButtonHideUnderline(
              //             child: DropdownButton<Faculty>(
              //               //value: 'Helwan University',
              //               hint: Text(
              //                 selectedFaculty == null
              //                     ? 'Faculty'
              //                     : selectedFaculty.name,
              //                 style: TextStyle(color: Palette.lightBlue),
              //               ),
              //               iconSize: 32.0,
              //               iconEnabledColor: Palette.lightBlue,
              //               isExpanded: true,
              //               style: TextStyle(color: Palette.lightBlue),
              //               dropdownColor: Palette.midBlue,
              //               items: selectedUniversity.faculties
              //                   .map((Faculty faculty) {
              //                 return new DropdownMenuItem<Faculty>(
              //                   value: faculty,
              //                   child: new Text(faculty.name),
              //                 );
              //               }).toList(),
              //               onChanged: (faculty) {
              //                 setState(() {
              //                   selectedFaculty = faculty;
              //                 });
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              SizedBox(
                height: 5.0,
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
                  onPressed: () async {
                    //TODO update user info
                    loadingBox(context);
                    User user = User(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                    );
                    var res = await model.userController.updateUserInfo(
                        user,
                        passwordController.text,
                        image,
                        model.currentUser.token);
                    Navigator.pop(context);
                    if (res['errors'] != null) {
                      _showErrors(context, res['errors']);
                    } else {
                      _UpdatedSuccessfully(context);
                    }
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
