import 'package:flutter/cupertino.dart';

class Lesson {
  final String id;
  final String description;
  final String title;
  final String imageUrl;
  final String videoUrl;
  final String pdfUrl;
  final int price;

  Lesson(
      {@required this.id,
      @required this.description,
      @required this.title,
      this.imageUrl,
      this.videoUrl,
      this.pdfUrl,
      @required this.price});
}
