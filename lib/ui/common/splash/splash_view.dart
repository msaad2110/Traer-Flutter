


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/splash/splash_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/custom_image_view.dart';

class SplashView extends StackedView<SplashViewModel>{


  @override
  Widget builder(BuildContext context, SplashViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary,
                    // Replace with your desired colors
                    theme.colorScheme.primary,
                  ],
                ),
              ),
            ),
            // GIF image centered on the screen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
              child: CustomImageView(
              imagePath: ImageConstant.imgLogo, width: MediaQuery.sizeOf(context).width * 0.6,fit: BoxFit.fill,

               )

              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) {
   return SplashViewModel();
  }

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;




}