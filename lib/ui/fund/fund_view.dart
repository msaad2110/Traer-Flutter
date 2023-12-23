

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/fund/fund_viewmodel.dart';

class FundView extends StackedView<FundViewModel>{

  @override
  Widget builder(BuildContext context, FundViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  FundViewModel viewModelBuilder(BuildContext context) {
    return FundViewModel();
  }

  @override
  void onViewModelReady(FundViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}