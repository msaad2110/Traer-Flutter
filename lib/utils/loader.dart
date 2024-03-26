



import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader{


 static Widget loader(){

    return SizedBox(height: 200,width: 200,child: Image.asset('assets/inspire_logo_gif.gif'));

  }

 static Widget centerloader(BuildContext context){

   return Container(
       color : Colors.black.withOpacity(0.1),
       height : MediaQuery.sizeOf(context).height,
       width : MediaQuery.sizeOf(context).width,
       child: Center(child: SizedBox(height: 200,width: 200,child: Image.asset('assets/inspire_logo_gif.gif'))));

 }
}