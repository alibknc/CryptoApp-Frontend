import 'dart:convert';
import 'package:crypto_app/src/models/coin.dart';
import 'package:http/http.dart';

class ApiService{
  Client client;
  String apiLink = "http://10.0.2.2:8080/api/v1";

  ApiService(){
    client = Client();
  }

  @override
  Future<List> getSymbolList() async {
    List list = [];

    var response = await client.get(Uri.parse("$apiLink/info"));
    if (response.statusCode == 200) {
      print(response.body);
      list.addAll(json.decode(Utf8Decoder().convert(response.bodyBytes))['symbols'] as List);
    } else {
      throw Exception('Failed to get symbol list');
    }

    return list;
  }

  @override
  Future<List<Coin>> getLastPrices(List symbols) async {
    List<Coin> list = [];

    await Future.wait(symbols.map((element) async{
      var response = await client.get(Uri.parse("$apiLink/ticker?symbol=$element"));
      if (response.statusCode == 200) {
        Coin coin = Coin(element, json.decode(Utf8Decoder().convert(response.bodyBytes))['lastPrice']);
        list.add(coin);
      } else {
        throw Exception('Failed to get last prices');
      }
    }).toList());

    return list;
  }
}