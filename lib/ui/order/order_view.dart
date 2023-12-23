

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/order/order_viewmodel.dart';

class OrderView extends StackedView<OrderViewModel>{


  @override
  Widget builder(BuildContext context, OrderViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  OrderViewModel viewModelBuilder(BuildContext context) {
    return OrderViewModel();
  }

  @override
  void onDispose(OrderViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(OrderViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}