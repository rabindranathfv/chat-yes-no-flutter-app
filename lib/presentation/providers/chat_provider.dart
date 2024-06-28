import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no.dart';
import 'package:yes_no_app/domain/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollCtrl = ScrollController();
  final GetYesNo getYesNo = GetYesNo();

  List<Message> messageList = [
    Message(text: 'hello babe', fromWho: FromWho.me),
    Message(text: 'did you came back from work?', fromWho: FromWho.me),
    Message(text: 'did you came back from work?', fromWho: FromWho.hers),
  ];

  Future<void> sendMessage(String msg) async {
    if (msg.isEmpty) return;
    final newMessage = Message(text: msg, fromWho: FromWho.me);
    messageList.add(newMessage);

    if ( msg.endsWith('?') ) {
     herReply();
    }

    notifyListeners();
    await moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollCtrl.animateTo(chatScrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<void> herReply() async {

    final herMsg = await getYesNo.getAnswer();
    messageList.add(herMsg);

    notifyListeners();
    await moveScrollToBottom();
  }
}
