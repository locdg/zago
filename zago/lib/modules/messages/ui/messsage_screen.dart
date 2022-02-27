import 'package:flutter/material.dart';
import 'package:zago/modules/messages/bloc/message_bloc.dart';
import 'package:zago/modules/messages/model/messsage.dart';
import 'package:zago/modules/messages/ui/components/item_message.dart';
import 'package:zago/utils/size_utils.dart';
import 'package:easy_localization/easy_localization.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen>
    with AutomaticKeepAliveClientMixin<MessageScreen> {
  MessageBloc bloc = MessageBloc();
  @override
  void initState() {
    bloc.getListMessage();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return StreamBuilder<List<Message>>(
        stream: bloc.listMessageStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list?.length,
                itemBuilder: (context, index) {
                  return ItemMessage(message: list![index]);
                });
          }
          return const SizedBox();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
