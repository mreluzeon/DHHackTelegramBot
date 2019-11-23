import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main(List<String> arguments) {
 
  var TOKEN = "1066697640:AAEd1o4HYriYTgeAI0ZTsJgWIzX5-o0JlZo";
  
    List<int> charachters = [1105, 1025, 1081, 1094, 1091, 1082, 1077, 1085, 1075, 1096, 1097, 1079, 1093, 1098, 1092, 1099, 1074,
			    1072, 1087, 1088, 1083, 1076, 1078, 1101, 1103, 1095, 1089, 1084, 1080, 1090, 1100, 1073, 1102, 1049, 1062, 
			    1059, 1050, 1045, 1053, 1043, 1064, 1065, 1047, 1061, 1066, 1060, 1067, 1042, 1040, 1055, 1056, 1054, 1051, 1044, 
			    1046, 1069, 1071, 1063, 1057, 1052, 1048, 1058, 1068, 1041, 1070] + [46, 44, 45, 33, 63] + [48, 49, 50, 51, 52, 53, 54, 55, 56, 57];


  TeleDart teledart = TeleDart(Telegram(TOKEN), Event());
  teledart.start().then((me) => print('${me.username} is initialised'));
  teledart
      .onCommand('wisdom')
      .listen(((message) => teledart.replyMessage(message, 'Небо зелёное')));
  teledart
      .onCommand('selfie')
      .listen(((message) => teledart.replyMessage(message, 'Небо зелёное'))); // TODO: Send photos
  teledart
    .onCommand("start")
    .listen((mes) => teledart.replyMessage(mes, "hello, ${mes.from.first_name}"));
  teledart
      .onMessage()
      .listen((mes){
	bool flag = true;
	String text = mes.text;
	text.codeUnits.forEach((char){
	    if (!charachters.contains(char)){
		flag = false;
	    }
	});
	print(text.codeUnits);
	if (flag){
	    String data = json.encode({"label": "text", "text":text});
	    var resp = PostReq(data);
	    resp.then((txt) => teledart.replyMessage(mes, txt));
	}
      });
}

Future<String> PostReq(String data) async {
    var url = "http://172.20.22.87:5000";
    var response = await http.post(url, body: data);
    Map resp = json.decode(response.body);
    return resp["text"];
}
