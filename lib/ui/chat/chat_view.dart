

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/chat/chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel>{

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) {
    // TODO: implement viewModelBuilder
    return ChatViewModel();
  }

  @override
  void onViewModelReady(ChatViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}