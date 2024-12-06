import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/chat_users/chat_users_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';

class ChatUsersView extends StackedView<ChatUsersViewModel>{

  @override
  Widget builder(BuildContext context, ChatUsersViewModel viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context, "Chat", onBackClicked: () {

            }),
            body: Column(
              children: [
                SizedBox(height: 2),
                Expanded(child: StreamBuilder<List<types.Room>>(
                  stream: FirebaseChatCore.instance.rooms(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          bottom: 200,
                        ),
                        child: const Text('No rooms'),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final room = snapshot.data![index];

                        return GestureDetector(
                          onTap: () {

                            locator<NavigationService>().navigateTo(Routes.chatView,
                                arguments: ChatViewArguments(room: room));

                            /*   Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  room: room,
                                ),
                              ),
                            );*/
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                _buildAvatar(room),
                                Text(room.name ?? ''),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ))

              ],
            ),
           ));

  }

  Widget _buildAvatar(types.Room room) {
    var color = appTheme.gray100;

    /*if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
              (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }*/
    print(room.name);
    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    List<String> words = name.split(' ');
    String initials = words.map((word) => word[0]).join('');

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: !hasImage ? Colors.transparent : color,
        backgroundImage: !hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
        child: hasImage
            ? Text(
          name.isEmpty ? '' :" ${initials.toUpperCase()}",
          style: const TextStyle(color: Colors.black),
        )
            : null,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title,
      {required Function() onBackClicked}) {
    return CustomAppBar(
        leadingWidth: 26,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgUserPrimary,
            margin: EdgeInsets.only(left: 20, top: 21, bottom: 24),
            onTap: () {
              //onTapClose(context);
              onBackClicked();
            }),
        title: AppbarSubtitleThree(
            text: title, margin: EdgeInsets.only(left: 14)));
  }

  @override
  ChatUsersViewModel viewModelBuilder(BuildContext context) {
    return ChatUsersViewModel();
  }

  @override
  void onViewModelReady(ChatUsersViewModel viewModel) {
   // locator<NavigationService>().navigateTo(Routes.chatView);
 /*   getSingleUserById("testone@gmail.com").then((user) async {
      if (user!.id.isNotEmpty) {
        print("Found user: ${user.firstName} ${user.lastName}");
        final room = await FirebaseChatCore.instance.createRoom(user);
         viewModel.room = room;
      } else {
        print("User with ID  not found");
      }
    });*/
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(ChatUsersViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Future<types.User?> getSingleUserById(String email) async {
    types.User? record  = null;
    List<types.User> list = await getAllUsers();
    print(list);
    for (types.User user in list) {
      if(user.metadata!["email"] == email){
        record = user;
      }
    }
    return record == null ?  types.User(id: "") : record;
  }

  Future<List<types.User>> getAllUsers() async {
    Stream<List<types.User>> users = await FirebaseChatCore.instance.users();
    final completer = Completer<List<types.User>>();
    users.forEach((foundList){
      completer.complete(foundList.cast<types.User>()); // Cast and complete
    });
    return completer.future;
  }

}