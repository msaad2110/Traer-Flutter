



import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomLoader{


  static void showLoader(BuildContext context){
    context.loaderOverlay.show();
  }

 static void hideLoader(BuildContext context){
    context.loaderOverlay.hide();
  }


}