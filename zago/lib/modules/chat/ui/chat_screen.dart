import 'package:flutter/material.dart';
import 'package:zago/common/widget/space.dart';
import 'package:zago/modules/chat/ui/components/chat_body.dart';
import 'package:zago/modules/messages/model/messsage.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/themes/styles_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: const ChatMessage(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.nameContact, style: StyleText.whiteTitle),
          Vertical(space: 3),
          const Text('Truy cập 50 phút trước',
              style: StyleText.defaultWhiteSmall)
        ],
      ),
      actions: [
        const Icon(Icons.phone),
        Horizontal(),
        const Icon(Icons.phone_android_outlined),
        Horizontal(),
        const Icon(
          Icons.menu_open,
          size: AppSize.sizeIcon2,
        ),
        Horizontal(),
      ],
    );
  }
}
