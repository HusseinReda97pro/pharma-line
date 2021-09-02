import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/forgot_password.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/screens/signup.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:pharma_line/widgets/loading_box.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _radioGroup = 1;

  Future<void> _login(
      {@required BuildContext context, @required MainModel model}) async {
    loadingBox(context);
    var res = await model.login(
        email: emailController.text.trim(), password: passwordController.text);
    Navigator.pop(context);
    if (res != null) {
      _showErrors(context, res['errors']);
    } else {
      if (model.currentUserType == UserType.TEACHER) {
        model.getTeacherCourses(token: model.currentUser.token);
      }
      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.route));
    }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 350,
                    height: 200,
                  ),
                  Text(
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Palette.lightBlue, fontSize: 20),
                  ),
                  Input(
                    hint: 'E-mail',
                    controller: emailController,
                  ),
                  Input(
                    hint: 'password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Palette.lightBlue, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // ButtonBar(
                  //   alignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       'Student',
                  //       style:
                  //           TextStyle(fontSize: 16, color: Palette.lightBlue),
                  //     ),
                  //     Radio(
                  //       value:
                  //           model.currentUserType == UserType.STUDENT ? 1 : 0,
                  //       fillColor: MaterialStateColor.resolveWith(
                  //           (states) => Palette.lightBlue),
                  //       groupValue: _radioGroup,
                  //       onChanged: (_) {
                  //         setState(() {
                  //           model.currentUserType = UserType.STUDENT;
                  //         });
                  //       },
                  //     ),
                  //     Radio(
                  //       value:
                  //           model.currentUserType == UserType.TEACHER ? 1 : 0,
                  //       activeColor: Palette.lightBlue,
                  //       hoverColor: Colors.red,
                  //       groupValue: _radioGroup,
                  //       fillColor: MaterialStateColor.resolveWith(
                  //           (states) => Palette.lightBlue),
                  //       onChanged: (_) {
                  //         setState(() {
                  //           model.currentUserType = UserType.TEACHER;
                  //         });
                  //       },
                  //     ),
                  //     Text(
                  //       'Teachr',
                  //       style:
                  //           TextStyle(fontSize: 16, color: Palette.lightBlue),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Palette
                                .lightBlue; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () async {
                        _login(context: context, model: model);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Palette
                                .darkBlue; // Use the component's default.
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Palette.lightBlue),
                          ),
                        ),
                      ),
                      onPressed: () {
                        model.getUniversities();
                        Navigator.pushNamed(context, SignUpScreen.route);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Palette.lightBlue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
