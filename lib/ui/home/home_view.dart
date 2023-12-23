
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel>{

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel();
  }

  @override
  void onDispose(HomeViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }


  @override
  void onViewModelReady(HomeViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}