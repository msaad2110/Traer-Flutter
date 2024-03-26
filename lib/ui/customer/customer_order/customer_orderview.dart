



import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/customer/customer_order/customer_order_viewmodel.dart';

class CustomerOrderView extends StackedView<CustomerOrderViewModel>{

  @override
  Widget builder(BuildContext context, CustomerOrderViewModel viewModel, Widget? child) {
    // TODO: implement builder
    throw UnimplementedError();
  }

  @override
  CustomerOrderViewModel viewModelBuilder(BuildContext context) {
    // TODO: implement viewModelBuilder
    throw UnimplementedError();
  }

  @override
  void onViewModelReady(CustomerOrderViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

  @override
  void onDispose(CustomerOrderViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }
}