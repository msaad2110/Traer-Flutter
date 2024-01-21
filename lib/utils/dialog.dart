

import 'package:flutter/material.dart';
import 'package:traer/utils/appstrings.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/customtextstyle.dart';


class CustomDialog{


  static Future showErrorDialog(BuildContext cont  , {String message = "Error occured try again" , required Function() onPressedDialog}){

    return showDialog(context: cont, builder: (BuildContext context , ){
      return PopScope(
          canPop: false,
          onPopInvoked: (value){

          },
          child: AlertDialog(
            title: Text(AppStrings.appName),
            content: Text(message),
            actions: <Widget>[

              TextButton(
                  onPressed:  (){
                    onPressedDialog();
                    Navigator.pop(context);
                  }, child: Text("OK",style: CustomTextStyle.customStyle(16.0, ColorsField.blackColor, FontWeight.normal),))

            ],
          )
      );
    },barrierDismissible: false);

  }


  static Future showSuccessDialog(BuildContext cont  , {String message = "Success" , required Function() onPressedDialog}){

    return showDialog(context: cont, builder: (BuildContext context , ){
      return PopScope(
          canPop: false,
          onPopInvoked: (value){

          },
          child: AlertDialog(
            title: Text(AppStrings.appName),
            content: Text(message),
            actions: <Widget>[

              TextButton(
                  onPressed:  (){

                    onPressedDialog();
                  }, child: Text("OK",style: CustomTextStyle.customStyle(16.0, ColorsField.blackColor, FontWeight.normal),))

            ],
          )
      );
    },barrierDismissible: false);

  }


  static Future showCustomDialog(BuildContext cont , String title , String message ,String buttonText,Function() onPressed){



    return showDialog(context: cont, builder: (BuildContext context , ){
      return PopScope(
        canPop: false,
        onPopInvoked: (value){

        },
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Stack(
            children: [
              Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          colors: <Color>[
                            ColorsField.whiteColor,
                            ColorsField.whiteColor,
                          ],
                        )
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/inspire_logo.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align( alignment :Alignment.centerLeft,child: Text(title,style: CustomTextStyle.customStyle(16, Colors.black, FontWeight.w500),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(alignment:Alignment.centerLeft,child: Text(message,style: CustomTextStyle.customStyle(13, Colors.black, FontWeight.w500))),
                        ),
                        Align(alignment:Alignment.centerRight,child: gotoHomeButton(context,onPressed,buttonText))

                      ],
                    ),
                  ),
                ],

              ),
/*
              Container(
                height: 100,
                color: Colors.transparent,
                child:   Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/success_check.png'),
                    ),
                  ),
                ),
              ),
*/
            ],
          ),
        ),
      );
    },barrierDismissible: false);

  }



 static Widget gotoHomeButton(BuildContext context , Function() onPressed , String buttonText){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(left: 10.0,right: 10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          ColorsField.whiteColor,
                          ColorsField.whiteColor,
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    onPressed();
                  },
                  child:  Align(alignment : Alignment.centerRight,child: Text(buttonText,style: CustomTextStyle.customStyle(16, ColorsField.orangeColor, FontWeight.w500),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}