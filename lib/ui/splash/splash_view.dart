


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/splash/splash_viewmodel.dart';

class SplashView extends StackedView<SplashViewModel>{


  @override
  Widget builder(BuildContext context, SplashViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(color: Colors.green,),
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