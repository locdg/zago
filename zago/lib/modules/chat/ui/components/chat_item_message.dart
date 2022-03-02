import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zago/common/widget/space.dart';
import 'package:zago/modules/chat/model/item_chat_obj.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/themes/styles_text.dart';
import 'package:zago/utils/size_utils.dart';

class ChatItemMessage extends StatelessWidget {
  final ItemChatObj itemChatObj;

  const ChatItemMessage({Key? key, required this.itemChatObj})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          itemChatObj.isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: SizeConfig.screenWidth * 0.75, minWidth: 140),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD2DCE6)),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: itemChatObj.isFromMe
                      ? const Color(0xFFD2EFFF)
                      : AppColors.kWhite),
              padding: EdgeInsets.all(
                  itemChatObj.isFromMe ? AppSize.kSize20 : AppSize.kSize10),
              child: buildContentMessage()),
        ),
      ),
    );
  }

  Row buildContentMessage() {
    return Row(
      children: [
        itemChatObj.isFromMe
            ? const SizedBox()
            : const CircleAvatar(
                radius: AppSize.kSize20,
                backgroundImage:
                    NetworkImage('https://reqres.in/img/faces/2-image.jpg')),
        Horizontal(space: itemChatObj.isFromMe ? 0 : AppSize.kSize10),
        Expanded(
          child: getTypeMessage(itemChatObj.type),
        ),
      ],
    );
  }

  Widget getTypeMessage(TypeMessage type) {
    if (type == TypeMessage.image) {
      return Image.file(File(itemChatObj.imagePath), fit: BoxFit.contain);
    }
    return Text(
      itemChatObj.messsage,
      style: StyleText.defaultBlack,
    );
  }
}
