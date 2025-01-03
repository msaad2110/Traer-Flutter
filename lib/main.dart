import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_view.dart';
import 'package:traer/utils/CreateMaterialColor.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/pref_utils.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


final createMaterialColor = CreateMaterialColor();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NSSLKIhgCooPLemRL3Wbm7HRoFjV14PlewzLTvuUwCcdGkeXt5goHViWkW47UIm3F2oaHUCMxvBrh0cAJfpkwRX00N9habFs5";
  await Stripe.instance.applySettings();
  await setupLocator();
  await FaceCamera.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  /*await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );*/
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

//https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74



