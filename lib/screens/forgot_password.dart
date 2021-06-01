import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/screens/reset_password.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/input.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
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
      child: Consumer<MainModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Forgot Password"),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Input(
                hint: 'E-mail',
                controller: emailController,
              ),
              Container(
                width: double.infinity,
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
                  onPressed: () async {
                    var res = await model.forgotPassword(emailController.text);
                    if (res['errors'] != null) {
                      _showErrors(context, res["errors"]);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPassword(
                                email: emailController.text,
                              )));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(res['message'],
                            style: TextStyle(color: Palette.darkBlue)),
                        backgroundColor: Palette.lightBlue,
                      ));
                    }
                  },
                  child: Text(
                    'Send Reset Code',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
