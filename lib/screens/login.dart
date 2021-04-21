import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/screens/signup.dart';
import 'package:pharma_line/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                    //TODO login
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
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Palette.darkBlue; // Use the component's default.
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Palette.lightBlue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SignUpScreen();
                        },
                      ),
                    );
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
      ),
    );
  }
}
