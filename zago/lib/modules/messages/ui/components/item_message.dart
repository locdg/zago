import 'package:flutter/material.dart';
import 'package:zago/common/routes/routes.dart';
import 'package:zago/common/widget/badge.dart';
import 'package:zago/common/widget/space.dart';
import 'package:zago/modules/chat/ui/chat_screen.dart';
import 'package:zago/modules/messages/model/messsage.dart';
import 'package:zago/themes/app_colors.dart';
import 'package:zago/themes/app_sizes.dart';
import 'package:zago/utils/time_utils.dart';

class ItemMessage extends StatelessWidget {
  const ItemMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  final heightItem = 100.0;
  /* Style Text */
  final textDecreption = const TextStyle(
      color: AppColors.kColorTextLight, fontSize: AppSize.sizeText14);
  final textDecreptionBold = const TextStyle(
      color: AppColors.kColorText,
      fontSize: AppSize.sizeText14,
      fontWeight: FontWeight.w700);
  final textTitleBold = const TextStyle(
      color: AppColors.kColorText,
      fontSize: AppSize.sizeText15,
      fontWeight: FontWeight.w700);
  final textTitle = const TextStyle(
      color: AppColors.kColorText, fontSize: AppSize.sizeText15);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Routes.push(context, ChatScreen(message: message));
      }),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.kSize10),
            height: heightItem,
            child: Row(children: [
              buildAvatar(),
              Horizontal(),
              buildColumn(),
            ]),
          ),
        ],
      ),
    );
  }

  /* Avatar */
  SizedBox buildAvatar() {
    return SizedBox(
      width: 70,
      height: 70,
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        backgroundImage: NetworkImage(message.avatar),
        radius: 50,
      ),
    );
  }

  /* Main Column */
  Expanded buildColumn() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                buildColumnText1(),
                Horizontal(space: AppSize.kSize5),
                buildColumnText2(),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black38)
        ],
      ),
    );
  }

  Expanded buildColumnText1() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextContent(
              message.isRead ? textTitle : textTitleBold, message.nameContact),
          Vertical(space: 4),
          buildTextContent(message.isRead ? textDecreption : textDecreptionBold,
              message.lastMessage),
        ],
      ),
    );
  }

  SizedBox buildColumnText2() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildTextContent(
              textDecreption, Time.getDate(message.lastTimeMessage)),
          Vertical(space: 4),
          message.isRead ? const SizedBox() : const Badge(isNew: true)
        ],
      ),
    );
  }

  Text buildTextContent(TextStyle style, String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
