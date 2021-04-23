import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';



//ignore: must_be_immutable
class ProfileImagePicker extends StatefulWidget {
  File image;
  final String imageUrl;
  MainModel model;
  ProfileImagePicker({this.image, this.imageUrl, this.model});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        widget.image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   // print(widget.imageUrl);
    return Container(
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
                    border: Border.all(color: Palette.lightBlue, width: 3.0),
                  ),
                  child: ClipOval(
                    child: widget.image != null
                        ? Image.file(
                            widget.image,
                            fit: BoxFit.cover,
                          )
                        : widget.imageUrl != null
                            ? Image.network(
                        "https://pharmaline.herokuapp.com/api/v1/student/profilePicture",
                      headers: {"Authorization":  widget.model.currentUser.token})
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
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
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
    );
  }
}
