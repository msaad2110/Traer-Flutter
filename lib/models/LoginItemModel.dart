

import 'package:traer/utils/image_constant.dart';

class LoginItemModel {
  LoginItemModel({
    this.rectangle,
    this.id,
  }) {
    rectangle = rectangle ?? ImageConstant.imgRectangle11;
    id = id ?? "";
  }

  String? rectangle;

  String? id;
}
