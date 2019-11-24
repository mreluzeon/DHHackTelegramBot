import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'dart:convert';

import 'package:TelegramBot/token.dart' as token;
import 'package:TelegramBot/TelegramBot.dart';

const String url = "http://172.20.22.87:5000";
const TOKEN = token.token;
const List<int> allwedCharacters = [45,46,44,63,33,113,119,101,114,116,121,117,105,111,112,97,115,100,102,103,104,106,107,108,122,120,99,118,98,110,109,81,87,69,82,84,89,85,73,79,80,83,68,70,71,72,74,75,76,58,90,88,67,86,66,78,77];

main(List<String> arguments) {
  TeleDart teledart = TeleDart(Telegram(TOKEN), Event());
  teledart.start().then((me) => print('${me.username} is initialised'));
  teledart
    .onCommand('wisdom')
    .listen(((message) => teledart.replyMessage(message, 'Небо зелёное')));
  teledart
    .onCommand('selfie')
    .listen(((message) => teledart.replyMessage(message, 'Здесь мы должны отправлять вам ФОТО')));
  teledart
    .onCommand("start")
    .listen((message) => teledart.replyMessage(message, "hello, ${message.from.first_name}"));
  teledart
    .onMessage()
    .listen((message){
      bool isMessageAllowed = true;
      String text = message.text;
      text.codeUnits.forEach((char){
        if (!allwedCharacters.contains(char)){
          isMessageAllowed = false;
        }
      });
      if (isMessageAllowed){
        String data = json.encode({"label": "text", "text":text});
        var resp = PostReq(url, data);
        resp.then((txt) => teledart.replyMessage(message, txt));
      }});
}

