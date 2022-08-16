import 'dart:convert';
import 'package:crypto_app/src/models/coin.dart';
import 'package:crypto_app/src/sevices/api_service.dart';
import 'package:crypto_app/src/widget/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  StompClient stompClient;
  final socketUrl = 'http://10.0.2.2:8080/websocket';

  String message = '';
  List<Coin> stockList;

  void onConnect(StompClient client, StompFrame frame) {
    client.subscribe(
        destination: '/topic/lastprice',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> obj = json.decode(frame.body);
            print(obj);
            List<Coin> stocks = [];
            for (int i = 0; i < obj['stock'].length; i++) {
              Coin stock = Coin(
                  "obj['stock'][i]['symbol']",
                  "obj['stock'][i]['price']");
              stocks.add(stock);
            }
            setState(() => stockList = stocks);
          }
        });
  }

  ScrollController _scrollController;
  TextEditingController _textEditingController;
  ApiService apiService;
  List symbols;
  List<Coin> coins;
  bool loading;

  @override
  void initState() {
    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
            url: socketUrl,
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
          ));
      stompClient.activate();
      print(stompClient.connected);
    }

    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    apiService = ApiService();
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    if (stompClient != null) {
      stompClient.deactivate();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          color: Color(0xFF4CDA63),
          onRefresh: () async {
            _textEditingController.text = "";
            await _getData();
          },
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  key: PageStorageKey("Market"),
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  itemCount: symbols.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF4F3F7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _textEditingController,
                          maxLines: 1,
                          cursorColor: Color(0xFF4CDA63),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              hintText: "Kripto Ara",
                              hintMaxLines: 1,
                              hintStyle: TextStyle(
                                color: Color(0xFF8F8F91),
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  color: Color(0xFF4CDA63),
                                ),
                              )),
                          onSubmitted: (String value) {},
                          onChanged: (String value) {},
                        ),
                      );
                    }
                    return CoinCard(key: UniqueKey(), onPressed: () {}, data: coins[index - 1]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 15,
                    );
                  },
                ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () => _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInCubic),
              backgroundColor: Color(0xFF4CDA63),
              foregroundColor: Colors.white,
              elevation: 0.0,
              child: Icon(
                Icons.arrow_upward,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getData() async {
    setState(() {
      loading = true;
    });

    List list = await apiService.getSymbolList();
    List<Coin> data = await apiService.getLastPrices(list);

    setState(() {
      symbols = list;
      coins = data;
      loading = false;
    });
  }
}
