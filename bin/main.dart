import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';
import 'package:TelegramBot/TelegramBot.dart';

main(List<String> arguments) {
 
  var TOKEN = "1066697640:AAEd1o4HYriYTgeAI0ZTsJgWIzX5-o0JlZo";
  
  TeleDart teledart = TeleDart(Telegram(TOKEN), Event());

  teledart.start().then((me) => print('${me.username} is initialised'));


  teledart
      .onCommand('hello')
      .listen(((message) => teledart.replyMessage(message, 'world')));
}
