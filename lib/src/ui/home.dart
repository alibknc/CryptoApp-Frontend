import 'package:crypto_app/src/ui/market.dart';
import 'package:crypto_app/src/widget/appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 150),
        child: CustomAppBar(
          title: "Market",
          height: 150,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                splashColor: Colors.white,
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          action: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                onPressed: () {},
                splashColor: Colors.white,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: MarketPage(),
    );
  }
}
