import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/common/api/base_api.dart';
import 'package:zago/common/api/dio_client.dart';
import 'package:zago/common/extensions/extension_int.dart';
import 'package:zago/modules/messages/model/messsage.dart';

class MessageRepo {
  String urlGetListMessage = "/albums";

  Future<List<Message>> getListMessage() async {
    List<Message> listMassage = [];
    try {
      Response messageData = await Api.instance.get(urlGetListMessage);
      final String response =
          await rootBundle.loadString('assets/datas/message_response.json');
      final jsonResponse = await json.decode(response);
      final result = BaseResponse<List>.fromJson(jsonResponse);
      if (result.statusCode.is200API()) {
        listMassage =
            result.data.map((jsonObj) => Message.fromJson(jsonObj)).toList();
      } else {
        dlog(result.statusMessage);
      }
    } on DioError catch (e) {
      dlog('Error: ${e.message}');
    }
    return listMassage;
  }
}