



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/document_types.dart' as documentTypes;
import 'package:traer/models/documents.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class UploadDocumentViewModel extends BaseViewModel{
  final service = locator<RestService>();
  List<documentTypes.Data> allDocuments = [];

  PageController pageController  = PageController(initialPage: 0);

  int currentIndex = 0;

  Future<documentTypes.DocumentType>  getDocumentTypes() async {

    documentTypes.DocumentType responseModel = await service.getDocumentTypes();

    return  responseModel;

  }



  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    //notifyListeners();
  }

 /* Future<List<Documents>> getDocumentTypes() async {
    List<Documents> list = await [
      Documents(0, "National Identity Card"),
      Documents(1, "Driving License"),
      Documents(2, "Passport")
    ];

    return list;
  }*/



  (String , String ) getTitle(int documentID){

    if(documentID == 2){
      return ("National Identity Card Front" , "National Identity Card Back" );
    }else if(documentID == 3){
      return ("Driving License Front","Driving License Back");
    }else if(documentID == 4){
      return ("Passport","Passport");
    }else{
       return ("Upload Document" , "Upload Document") ;
    }
  }


  (String , String ) getBodyText(int documentID){

    if(documentID == 2){
      return ("Please provide us with a good photo of your National Identity Card. Make sure to capture front side and photograph the " , "Please provide us with a good photo of your National Identity Card. Make sure to capture back side and photograph the " );
    }else if(documentID == 3){
      return ("Please provide us with a good photo of your Driving License Card. Make sure to capture front side and photograph the ","Please provide us with a good photo of your Driving License Card. Make sure to capture back side and photograph the ");
    }else if(documentID == 4){
      return ("Please provide us with a good photo of your Passport. Make sure to capture front side and photograph the ","Please provide us with a good photo of your Passport. Make sure to capture back side and photograph the ");
    }else{
      return ("Upload Document" , "Upload Document") ;
    }
  }



  Future<void> initPlatformState() async {}
}