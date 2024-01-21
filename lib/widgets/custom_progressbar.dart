


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traer/utils/image_constant.dart';

Widget customProgessBar (){
  return Center(
    child: Center(child: SizedBox(height: 100,width: 100,child: Image.asset(ImageConstant.loader))),
  );
}