import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zago/common/widget/space.dart';
import 'package:zago/modules/chat/bloc/chat_bloc.dart';
import 'package:zago/modules/chat/model/item_chat_obj.dart';
import 'package:zago/modules/chat/ui/components/chat_item_message.dart';
import 'package:zago/modules/chat/ui/components/chat_menu_type_message.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/utils/language_utils.dart';
import 'package:zago/utils/perrmission.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({Key? key}) : super(key: key);

  @override
  State<ChatMessage> createState() => ChatMessageState();
}

class ChatMessageState extends State<ChatMessage> {
  TextEditingController txtMessage = TextEditingController();
  ScrollController scrollController = ScrollController();
  ChatBloc bloc = ChatBloc();

  var showMenuBottom = false;

  @override
  void dispose() {
    txtMessage.dispose();
    scrollController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildListMessage(), buildInputMessage()],
    );
  }

  /* Build ListMessage */
  Expanded buildListMessage() {
    return Expanded(
      child: Container(
        color: const Color(0xFFDCE6F0),
        child: StreamBuilder(
            stream: bloc.senMessageStream,
            builder: (context, snapshot) {
              return ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSize.kSize10),
                  separatorBuilder: (context, index) {
                    return Vertical(space: AppSize.kSize20);
                  },
                  itemCount: fakeListItemChat.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return ChatMenuTypeMessage(
                      child:
                          ChatItemMessage(itemChatObj: fakeListItemChat[index]),
                    );
                  });
            }),
      ),
    );
  }

  /* Build Input Message */
  SizedBox buildInputMessage() {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Horizontal(space: AppSize.kSize5),
            getIcon(Icons.now_widgets_outlined, () {}),
            Horizontal(space: AppSize.kSize5),
            buildTextField(),
            buildListIcon(),
            Horizontal(space: AppSize.kSize5),
          ],
        ));
  }

  /* Build TextField Message */
  Expanded buildTextField() {
    return Expanded(
        child: TextField(
            onChanged: ((value) {
              if ([0, 1].contains(value.length)) {
                bloc.listenerInput(value);
              }
            }),
            controller: txtMessage,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: KeyLang.chatMessage.tr())));
  }

  /* Build List Icon  */
  StreamBuilder buildListIcon() {
    return StreamBuilder(
        stream: bloc.inputMessageStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? false;
          return data
              ? InkWell(
                  child: const Icon(Icons.send, color: AppColors.kPrimaryColor),
                  onTap: () async {
                    if (txtMessage.text.isNotEmpty) {
                      await scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                      bloc.sendMessage(txtMessage.text);
                      txtMessage.text = "";
                      bloc.listenerInput(txtMessage.text);
                    }
                  })
              : Row(
                  children: [
                    const ChatMenuTypeMessage(
                        child: Icon(Icons.more_horiz_outlined,
                            color: Colors.grey, size: AppSize.sizeIcon1)),
                    Horizontal(space: AppSize.kSize5),
                    getIcon(Icons.mic, () {}),
                    Horizontal(space: AppSize.kSize5),
                    getIcon(Icons.photo, () async {
                      final isSuccess =
                          await PermissionUtils.checkPermissionCamera();
                      if (isSuccess) {
                        bloc.saveImageLocalAndPushMessage();
                      }
                    }),
                  ],
                );
        });
  }

  InkWell getIcon(IconData iconData, Function press) {
    return InkWell(
        child: Icon(iconData, color: Colors.grey, size: AppSize.sizeIcon1),
        onTap: () {
          press();
        });
  }
}
