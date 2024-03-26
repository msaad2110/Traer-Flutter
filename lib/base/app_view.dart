

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/main.dart';
import 'package:traer/ui/common/splash/splash_view.dart';
import 'package:traer/utils/appstrings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppView extends StatelessWidget {

  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
        primarySwatch: createMaterialColor.createMaterialColor(const Color(0xFFe55f39)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'samsungsharpsans',
      ),
      home:  SplashView(),
      navigatorKey:  StackedService.navigatorKey ,
      onGenerateRoute:  StackedRouter().onGenerateRoute ,
    );
  }
}