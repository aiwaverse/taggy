import 'package:flutter/material.dart';

abstract class Managable {
  String shortInfo = "";
  String completeInfo = "";
  bool updateable = false;
  bool deletable = false;
  String getWarning(BuildContext context);
  Managable alterForUpdate(String content);
}
