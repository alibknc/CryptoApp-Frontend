import 'package:crypto_app/src/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoinCard extends StatelessWidget {
  final VoidCallback _onPressed;
  final Coin data;

  CoinCard({Key key, @required VoidCallback onPressed, @required this.data})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF4F3F7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CachedNetworkImage(
                    imageUrl: "https://www.citypng.com/public/uploads/preview/-51614559661pdiz2gx0zn.png",
                    placeholder: (BuildContext context, _) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (BuildContext context, _, __) =>
                        Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.symbol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          softWrap: true,
                        ),
                        Container(
                          height: 6,
                        ),
                        Text(
                          data.symbol,
                          style: TextStyle(
                            color: Color(0xFFAAAAAC),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding:
                  EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                  child: Container()/*CustomPaint(
                    foregroundPainter: MiniGraph(coin: _coin),
                  ),*/
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "₺${data.price}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 1,
                      ),
                      Container(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "40.76",
                            style: TextStyle(
                              color: Color(0xFF4CDA63),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                          ),
                          Container(
                            width: 3,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Color(0xFF4CDA63),
                            size: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}