import 'dart:io';

import 'package:flutter/material.dart';

class NewDataModel with ChangeNotifier {
  final int id;
  final String title;
  final int mobile;
  final String desc;
  final File img;
  final File vedio;
  final String device_key;

  NewDataModel({
    required this.id,
    required this.title,
    required this.mobile,
    required this.desc,
    required this.img,
    required this.vedio,
    required this.device_key,
  });
}
