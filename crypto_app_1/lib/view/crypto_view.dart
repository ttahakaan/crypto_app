import 'dart:io';

import 'package:crypto_app_1/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({Key? key}) : super(key: key);

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  @override
  void initState() {
    super.initState();
  }

  List<CoinList>? _items = [];
  String? name;
  bool _isloading = false;

  void _changeLoading() {
    setState(() {
      _isloading = !_isloading;
    });
  }

  Future<void> fetchPostItems() async {
    _changeLoading();
    final response = await Dio().get(
        'https://api.nomics.com/v1/currencies/ticker?key=3ca25f6bb95fd0b95a9e792eff0df7d49abc852a');
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;

      if (datas is List) {
        setState(() {
          _items = datas.map((e) => CoinList.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Center(child: Text("Coin List")),

        automaticallyImplyLeading: true,

        title: Text(name ?? ''),
        centerTitle: true,
        actions: [
          _isloading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : ListView.builder(
              itemCount: _items?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  child: _items![index].logoUrl.endsWith("svg")
                                      ? SvgPicture.network(
                                          _items![index].logoUrl,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
                                          _items![index].logoUrl,
                                          fit: BoxFit.fill,
                                        ))
                            ],
                          ))),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_items![index].id),
                          Text("${_items![index].rank}.${_items![index].id}"),
                          // Text(_items![index].rank),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text(_items![index].marketCap)],
                      )),
                      const VerticalDivider(),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("\$${_price(_items![index].price)}"),
                              Text(
                                  "\$${_milionBilion(_items![index].marketCap)}"),
                            ],
                          )),
                      const VerticalDivider(),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _items![index]
                                          .the1D
                                          .priceChangePct
                                          .contains("-")
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: _items![index]
                                          .the1D
                                          .priceChangePct
                                          .contains("-")
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                Text(
                                  _items![index]
                                          .the1D
                                          .priceChangePct
                                          .contains("-")
                                      ? ("\$${_items![index].the1D.priceChangePct}")
                                      : ("\$${_items![index].the1D.priceChangePct}"),
                                  style: TextStyle(
                                    color: _items![index]
                                            .the1D
                                            .priceChangePct
                                            .contains("-")
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text("\$${(_items![index].the1D.volume)}"),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class SvgPicture {
  static network(logoUrl, {required BoxFit fit}) {}
}

_milionBilion(String marketcap) {
  String newMarketcap;
  if (6 >= marketcap.length) {
    newMarketcap = '${marketcap.substring(0, 3)}M';
  } else {
    newMarketcap = '${marketcap.substring((marketcap.length - 9))}B';
  }
  return newMarketcap;
}

_price(String price) {
  String newPrice;
  newPrice = double.parse(price).toStringAsFixed(3);
  return newPrice;
}
