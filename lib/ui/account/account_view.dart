


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/account/account_viewmodel.dart';

class AccountView extends StackedView<AccountViewModel>{


  @override
  Widget builder(BuildContext context, AccountViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  AccountViewModel viewModelBuilder(BuildContext context) {
    return AccountViewModel();
  }

  @override
  void onViewModelReady(AccountViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}