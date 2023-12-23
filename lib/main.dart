import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_view.dart';
import 'package:traer/utils/CreateMaterialColor.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/pref_utils.dart';


final createMaterialColor = CreateMaterialColor();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: ColorsField.whiteColor, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]).then((value) {
    runApp(AppView());
  });
/*  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorsField.toolbarColor,
  ));*/
 // runApp(const AppView());
}

