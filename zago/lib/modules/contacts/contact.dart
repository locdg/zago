import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zago/common/abstract/my_loc.dart';

class Contract extends StatefulWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  State<Contract> createState() => ContractState();
}

class ContractState extends State<Contract> {
  final TextEditingController _controller = TextEditingController();

  StreamSocket streamSocket = StreamSocket();
  @override
  void initState() {
    streamSocket.connectWebSocket();
    // streamSocket.connectAndListen();
    super.initState();
    streamSocket.listenWebSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // _channel.sink.close();
    _controller.dispose();
    streamSocket.dispose();
    super.dispose();
  }
}

class StreamSocket {
  late WebSocketChannel _channel;
  Socket socket = io(
      'wss://socket.polygon.io/stocks',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
    // socket.dispose();
  }

  void connectAndListen() {
    socket.connect();
    socket.onConnect((_) {
      dlog('connect');
      socket.emit('msg', 'test');
    });

    socket.onConnectError((data) => dlog(data.toString()));

    //When an event recieved from server, data is added to the stream
    // socket.on('event', (data) => addResponse);
    // socket.onDisconnect((_) => print('disconnect'));
  }

  void connectWebSocket() {
    _channel =
        // WebSocketChannel.connect(Uri.parse('wss://socket.polygon.io/stocks'));
        WebSocketChannel.connect(Uri.parse('wss://ws-feed.pro.coinbase.com'));
  }

  void listenWebSocket() {
    _channel.stream.listen(
      (dynamic message) {
        dlog(message);
        // _channel.sink.add(
        //   jsonEncode(
        //       {"action": "auth", "params": "317RPpmYou477pnUB2fQ3wghn1pPfH2q"}),
        // );
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');

        reconnect();
      },
    );
    _channel.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": [
                "BTC-EUR",
              ]
            }
          ]
        },
      ),
    );
  }

  reconnect() async {
    // if (_channel != null) {
    //   await Future.delayed(const Duration(seconds: 4));
    // }

    // print(new DateTime.now().toString() + " Starting connection attempt...");
    // connectWebSocket();
    // print(new DateTime.now().toString() + " Connection attempt completed.");
  }
}
