

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UploadIDBackViewModel extends BaseViewModel{
  ValueNotifier<File?>  image = ValueNotifier<File?>(null);

  Future<void> initPlatformState() async {}
}